module Jekyll
    class PopupImageMacroTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            bits = text.split
            @href = bits[0]
            @title = ''
            if bits.size > 1
                @title = bits.slice(1, bits.size).join(' ')
            end
        end

        def render(context)
            baseurl = context.registers[:site].config['baseurl']
            @href = "#{baseurl}/#{@href}"
            img_text = "<img src=\"#{@href}\""
            if @title.size > 0
                img_text += " title=\"#{@title}\""
            end
            img_text += " />"
            "<a href=\"#{@href}\" class=\"image-link\">#{img_text}</a>"
        end
    end
end

Liquid::Template.register_tag('popup_image', Jekyll::PopupImageMacroTag)
