# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# Directory indexes
activate :directory_indexes

# Assets source
set :js_dir, "assets/javascripts"
set :css_dir, "assets/stylesheets"
set :images_dir, "assets/images"

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

activate :external_pipeline,
         name: :webpack,
         command: build? ? "npm run build" : "npm run watch",
         source: ".tmp/dist",
         latency: 1

# Development
configure :development do
  set :url_root, "http://localhost:4567/"
  activate :livereload do |reload|
    reload.no_swf = true
  end
end

after_configuration do
  # Proxy pages
  # https://middlemanapp.com/advanced/dynamic-pages/

  empreendimento = @app.data.empreendimentos.find do |_filename, empreendimento|
    @app.data.pages.home.empreendimento == empreendimento.title
  end
  proxy "/index.html", "/pages/index.html", locals: {empreendimento: empreendimento ? empreendimento[1] : nil}, ignore: true
  proxy "/contato.html", "/pages/contato.html", ignore: true
  proxy "/obrigado.html", "/pages/obrigado.html", ignore: true
  proxy "/corretores.html", "/pages/corretor.html", ignore: true
  proxy "/empreendimentos.html", "/pages/empreendimentos.html", ignore: true
  proxy "/institucional.html", "/pages/institucional.html", ignore: true
  proxy "/politicas-de-privacidade-e-termos-de-uso.html", "/pages/politicas-de-privacidade-e-termos-de-uso.html", ignore: true
  proxy "/projetos.html", "/pages/projetos.html", ignore: true

  @app.data.empreendimentos.each do |_filename, empreendimento|
    # empreendimentos is an array: [filename, {data}]
    condominio = @app.data.condominios.find do |_filename, condominio|
      empreendimento.condominio == condominio.title
    end

    proxy "/empreendimento/#{empreendimento[:title].parameterize}.html", "/pages/pagina-empreendimento.html",
    locals: {empreendimento: empreendimento, condominio: condominio ? condominio[1] : nil},
    ignore: true
  end

  @app.data.projetos.each do |_filename, projeto|
    proxy "/projeto/#{projeto[:title].parameterize}.html", "/pages/pagina-projeto.html",
    locals: {projeto: projeto},
    ignore: true
  end
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  #helper to set background images with asset hashes in a style attribute
  def background_image(image)
    "background-image: url('" << image_path(image) << "')"
  end

  def nav_link(link_text, url, options = {})
    options[:class] ||= ""
    options[:class] << " active" if url == current_page.url
    link_to(link_text, url, options)
  end

  def markdown(content)
     Tilt['markdown'].new { content }.render
  end

  def telefonize(tel)
    "tel:0" + tel.parameterize.gsub('-', '')
  end

  def whatsappize(whats)
    "55" + whats.parameterize.gsub('-', '')
  end
end

# Redirecionamento Netlify
ready do
  proxy "_redirects", "netlify-redirects", ignore: true
end

# Production
configure :production do
  set :url_root, "https://www.bracci.com.br"
  activate :minify_html
  activate :asset_hash, ignore: [/\.bmp\Z/, /\.jpg\Z/, /\.png\Z/, /\.gif\Z/, /\.svg\Z/, /\.ico\Z/]
end

