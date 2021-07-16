
#check l'ARGV entré
def check_if_user_gave_input
    abort("J'ai besoin d'un nom de dossier/pgme") if ARGV.empty?
    abort("pas d'espace stp, jonathan n'a pas encore optimisé le programme.") if ARGV.length > 1
end

#optimisations
#prendre un deuxième argument pour le nom de fichier .rb
#3e argument pour définir l'emplacement
#prend les gem moins sytématiques
#prendre comme argument l'add
# aller chercher un fichier text pour modèle du .rb, du fichier spec plutôt que d'utiliser file.puts
# ajouter une identation ?

#capter le nom souhaité du programme
def get_name
    return name = ARGV[0]
end

#crée le dossier parent et les dossier lib et spec du programme en utilisant l'ARGV
def create_folders(name)
    Dir.mkdir(name)
    Dir.mkdir("#{name}/lib")
    Dir.mkdir("#{name}/spec")
end

#crée le readme.md
def readme_create(name)
    File.open("#{name}/readme.md", "w")
end

#crée le fichier text du pgme ARGV.rb (conforme template)
def rb_create(name)
    file = File.open("#{name}/lib/#{name}.rb", "w")
    tab_gem = ["rubocop","pry","rspec","nokogiri","open-uri"]
    tab_gem.each {|gem| file.puts("require '#{gem}'")}
    file.puts
    file.puts("#tu peux commencer à écrire la première méthode de ton programme")
    file.puts("def first_method")
    file.puts("end")
    file.puts
    file.puts("#décris ton programme")
    file.puts("def perform(var)")
    file.puts("end")
    file.puts
    file.puts("perfom(var)")
    file.close
end

#crée le gemfile avec les gems habituelles
def gemfile_create(name)
    file = File.open("#{name}/gemfile", "w")
    file.puts("source 'https://rubygems.org'")
    file.puts
    tab_gem = ["rubocop","pry","rspec","nokogiri","open-uri"]
    tab_gem.each {|gem| file.puts("gem '#{gem}'")}
    file.close
end

#crée le template .rspec
def rspec_create(name)
    file = File.open("#{name}/spec/#{name}_spec.rb", "w")
    file.puts("require_relative '../lib/#{name}'")
    file.puts
    file.puts("describe 'la fonction METHOD' do")
    file.puts
    file.puts("  it 'DECRIRE METHOD' do")
    file.puts("    expect('METHOD'('ARG')).to eq('RESULTAT')")
    file.puts("  end")
    file.puts("end")
    file.puts("")
    file.close
end

#lance le bundle install du gem file et le rspec --init
def bundle_install(name)
    Dir.chdir(name)
    system("bundle install")
    system("rspec --init")
end

#lance la séquence git
def git_launch
    system("git init")
end


#ouvre VS code sur la racine créée
def vs_launch
    system("code .")
end

def perform
    check_if_user_gave_input
    name = get_name
    create_folders(name)
    readme_create(name)
    rb_create(name)
    gemfile_create(name)
    rspec_create(name)
    bundle_install(name)
    vs_launch
    git_launch
end

perform