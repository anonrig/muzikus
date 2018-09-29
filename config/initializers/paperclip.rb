Paperclip.interpolates(:s3_fr_url) do |att, style| 
    "#{att.s3_protocol}://s3-eu-central-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
end