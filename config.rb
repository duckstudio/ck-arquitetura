#Bootstrap is used to style bits of the demo. Remove it from the config, gemfile and stylesheets to stop using bootstrap
require "uglifier"

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :livereload
# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page "/partials/*", layout: false
page "/admin/*", layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

after_configuration do
  # Proxy pages
  # https://middlemanapp.com/advanced/dynamic-pages/

  empreendimento = @app.data.empreendimentos.find do |_filename, empreendimento|
    @app.data.pages.home.empreendimento == empreendimento.title
  end
  proxy "/index.html", "/pages/index.html", locals: {empreendimento: empreendimento ? empreendimento[1] : nil}, ignore: true
  proxy "/contato.html", "/pages/contato.html", ignore: true
  proxy "/obrigado.html", "/pages/obrigado.html", ignore: true
  proxy "/corretor.html", "/pages/corretor.html", ignore: true
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

# pretty urls
activate :directory_indexes

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

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  # Minify css on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript, ignore: "**/admin/**", compressor: ::Uglifier.new(mangle: true, compress: { drop_console: true }, output: {comments: :none})

  # Use Gzip
  activate :gzip

  #Use asset hashes to use for caching
  #activate :asset_hash

end
