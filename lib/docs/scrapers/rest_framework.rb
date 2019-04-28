module Docs
  class RestFramework < UrlScraper
    self.name = 'Django REST Framework'
    self.release = '3.9.2'
    self.slug = 'rest_framework'
    self.type = 'mkdocs'
    self.base_url = 'https://www.django-rest-framework.org/'
    self.root_path = 'index.html'
    self.links = {
      home: 'https://www.django-rest-framework.org/',
      code: 'https://github.com/encode/django-rest-framework'
    }

    html_filters.push 'mkdocs/clean_html', 'rest_framework/clean_html', 'rest_framework/entries'

    options[:skip_patterns] = [
      /\Atopics\//,
      /\Acommunity\//,
    ]

    options[:attribution] = <<-HTML
      Copyright 2011&ndash;present Encode OSS Ltd<br>
      Licensed under the BSD License.
    HTML

    private

    def handle_response(response)
      # Some scrapped urls don't have ending slash
      # which leads to page duplication
      if !response.url.path.ends_with?('/') && !response.url.path.ends_with?('index.html')
        response.url.path << '/'
      end
      super
    end
  end
end
