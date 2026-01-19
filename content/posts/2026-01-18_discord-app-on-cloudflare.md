+++
date = '2026-01-18T03:40:50Z'
draft = false
title = 'Discord App on Cloudflare'
+++

I went through Discord's tutorial for [building your first Discord app](https://discord.com/developers/docs/quick-start/getting-started) that has you complete a starter Express.js server to handle webhooks from your Discord server but doesn't walk you through how you might deploy it.
I went through the exercise of deploying it to Cloudflare Worker and making the adjustments needed for it to work in that serverless environment.
I struggled with two issues moving to Cloudflare: one was how to persist game state, and another was how to properly make outgoing API requests.
After learning more about the Cloudflare serverless computing model and some of Cloudflare's building blocks, I was able to solve my issues by rewriting the Discord app in a native Cloudflare handler.
I found Cloudflare's CLI `wrangler` easy-to-use, and with the generous free tier, I'm looking forward to building more proof-of-concept-type projects on Cloudflare.
I made my code available on Github [here](https://github.com/alextsui05/discord-example-app).
