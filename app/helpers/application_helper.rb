module ApplicationHelper
  def page_title(title = '', admin: false)
    base_title = admin ? 'ヒトカラナビ(管理画面)' : 'ヒトカラナビ'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      description: 'ヒトカラー目線でカラオケ店の評価を共有し、あなたのこだわりにあったお店をみつけましょう。',
      keywords: 'ヒトカラ,ひとりカラオケ,一人カラオケ', # キーワードを「,」区切りで設定する
      canonical: request.original_url, # 優先するurlを指定する
      noindex: !Rails.env.production?,
      # icon: [ #favicon、apple用アイコンを指定する
      #   { href: image_url('favicon.ico') },
      #   { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      # ],
      og: {
        site_name: :site,
        title: :title,
        description: :description, 
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      # fb: {
      #   app_id: '自身のfacebookのapplication ID'
      # },
      twitter: {
        card: 'summary_large_image',
        # site: '@ツイッターのアカウント名',
        image: image_url('ogp.png')
      }
    }
  end
end
