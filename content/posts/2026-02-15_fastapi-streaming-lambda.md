+++
date = '2026-02-15T00:01:38Z'
draft = false
title = 'Figured out API Gateway streaming with Lambda'
+++

AWS Lambda is a good option to build backend APIs, is made pretty accessible with SAM, and with Lambda Web Adapter acting as a reverse proxy to your app server, you can just write in your framework of choice knowing that it will just work on Lambda without worrying about the details.
However, the devil is in the details as you'd have to jump through hoops with Lambda Function URLs if you want to make use of response streaming e.g. for serving LLM tokens.
As of November 2025, API Gateway supports response streaming and solves this issue, but while there are a number of configuration methods, setting this up with SAM was a bit of a mystery.
To clear things up, I put together a starter SAM project that demonstrates a minimal template to set up a REST API with streaming endpoint handled by FastAPI.
The project is a good starting point for building backend APIs.
Here's a [link to the Github repository](https://github.com/alextsui05/hello-fastapi-zip).


# Response Streaming

I'll defer the intro to response streaming to this excellent [AWS blog announcing API Gateway streaming support](https://aws.amazon.com/blogs/compute/building-responsive-apis-with-amazon-api-gateway-response-streaming/).
Basically, response streaming allows the server to send data out incrementally, rather than wait until it's all collected before responding.
This way when you're chatting with your LLM, you can start reading the response as it's coming in.
Surprisingly, API Gateway didn't provide first-class support for this until November 2025.

# Configuration methods

The blog above mentions three main methods:

1. OpenAPI Spec - Make use of the [`x-amazon-apigateway-integration`](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions-integration.html) OpenAPI extension to enable streaming.
Apparently, you can define your REST API by including an OpenAPI specification.
2. Cloudformation - Configure the `Integration` property for the `AWS::ApiGateway::Resource` resource.
3. AWS CLI - Use the `aws apigw update-integration` command to enable streaming.

I had only been dabbling with basic SAM templates and none of these methods directly addressed what to do in SAM.
Nevertheless, I was determined to figure out a way forward.

# OpenAPI spec route

I had been going through the FastAPI guide and had a simple API built up.
With FastAPI, you can access the local `/openapi.json` endpoint and get a JSON dump of your server's OpenAPI specification.
Apparently you can upload an OpenAPI file on creating your REST API, either through the AWS Console, CLI, or through Cloudformation.
I tried to simply plug in my FastAPI's specification, but it resulted in errors.
I really couldn't get very good feedback about what the error was, so I gave up here.
I read on Reddit that it's a great feature, but maybe figuring out how to get it work is a project for another day.
Incidentally, the sample code from the AWS blog makes use of this method to configure the API - [see here](https://github.com/aws-samples/serverless-samples/blob/1d2614922c7dca63dc63e1f91cb48a64ad1d57b3/apigw-response-streaming/python-strands-lambda/api-gateway-config.yaml#L29-L34).
I can see it being a convenient way to configure the API integration if you happened to defined your API this way, but it didn't help me with my SAM template.

# AWS CLI route

I thought this would possibly be an easy method just to see that enabling the streaming could work.
First run `sam deploy` to deploy the API, then run `aws apigw update-integration` targeting the API that I'd like to enable streaming for.
Ideally I'd want to save the configuration in the template, but I just want to see it work.
However, even after updating the integration and calling the streaming API, I would always get an Internal Server Error response.
I enabled the logs and I was able to determine that the request was reaching Lambda and it was succeeding.
However, for some reason, the API Gateway response would always end with a 502 error, despite the fact that the Lambda integration was set up for streaming.
It wasn't until much later that I learned that changes to Lambda integration settings are not reflected in the API unless I create a new deployment of the API.

# Cloudformation route

I had a feeling SAM didn't have a way to do what I wanted.
With SAM, you make and configure an `AWS::Serverless::Function` resource, where you specify your Lambda and then your API mappings are generated implicitly from the `Events` property.
Take this snippet for example:

```yaml
Resources:
  HelloWorldFunction:
    Type: AWS::Serverless::Function # More info about Function Resource: https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#awsserverlessfunction
    Properties:
      CodeUri: hello_world/
      Handler: app.lambda_handler
      Runtime: python3.13
      Architectures:
        - x86_64
      Events:
        HelloWorld:
          Type: Api # More info about API Event Source: https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#api
          Properties:
            Path: /hello
            Method: get
```

Here the `GET /hello` verb/resource pair would be mapped to the specified Lambda handler.
Intuitively, if there was going to be any configuration to enable streaming here, it would go under `Events.HelloWorld.Properties`.
But looking into the [supported properties](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-property-function-api.html), I don't see anything related to integration or streaming at all.
It seemed like I couldn't get SAM to generate what I wanted, so I had to drop down to Cloudformation and manually define the resources that I needed:
- an `AWS::ApiGateway::RestApi` to be the top-level API that holds all the HTTP resources
- an `AWS::ApiGateway::Resource` to define the HTTP resource itself
- an `AWS::ApiGateway::Method` to define the HTTP verb to go with the resource. It's here where you can specify the `ResponseTransferMode` to be `STREAM` as mentioned on the AWS blog.
- an `AWS::Lambda::Permission` to allow the API Gateway principal to actually be able to invoke each Lambda function
- an `AWS::ApiGateway::Deployment` to actually make a snapshot of the API configurations. You also need an `AWS::ApiGateway::Stage` to make it all accessible, but for convenience, you can specify the `StageName` property on the deployment and have it generated.

I have a working example of all of this in the Github repository linked at the top of this page.


# Next Steps

This seems like a good feature request to pitch to the SAM project, but it appears from [this Github issue](https://github.com/aws/aws-sam-cli/issues/8606) that it has already been requested and being prioritized.
Who knows, we might be able to specify streaming in SAM easily by as early as next month.
For now, I have a nice setup to build serverless backends so the next step would be to integrate an LLM and do something fun.
