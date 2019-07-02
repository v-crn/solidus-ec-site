if ENV['S3_ACCESS_KEY_ID']
  Paperclip::Attachment.default_options.merge!(
    storage: :fog,
    fog_credentials: {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
			region: ENV['S3_REGION'],
			host: ENV['S3_HOST']
		},

		# S3バケットの指定
		fog_directory: ENV["S3_BUCKET"]

		#---アップロードするデータを一般公開しない場合の設定---
		# fog_public設定をfalseにすることでS3のURLへの
		# 直接アクセスを禁止できる
		# config.fog_public = false

		# S3の認証URLの有効期限（秒）の設定
		# config.fog_authenticated_url_expiration = 60
		#----------------------------------------------
  )

  Spree::Image.attachment_definitions[:attachment].delete(:url)
	Spree::Image.attachment_definitions[:attachment].delete(:path)
end