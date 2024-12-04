# README

rails new xxxxxxxxxxx -d postgresql

rails db:create

agregar bootstrap como gema al proyecto
		gem install bootstrap
		gem install jquery-rails
		gem install popper_js
		gem install sassc-rails
		gem install faker
		gem install figaro

2  agregamos la gema al Gemfile y ejecuta un bundle install
		bundle add bootstrap
		bundle add jquery-rails
		bundle add popper_js
		bundle add sassc-rails
		bundle add faker
		bundle exec figaro install

3 cambiar el nombre 
		application.css a application.scss
	
4 agregar en application.scss la linea
		@import "bootstrap";
	
5 agregar a application.js 
		import "bootstrap"
        //import "popper"

6 agregar en initializers/config/assets.rb
		Rails.application.config.assets.precompile += %w( application.scss bootstrap.min.js popper.js )
	
7 agregar en config/importmap.rb
		pin "popper", to: 'popper.js', preload: true
		pin "bootstrap", to: 'bootstrap.min.js', preload: true
		
8 descomentar en Gemfile y ejecutar bundle install
        gem "sassc-rails"

9 gem install devise
		bundle add devise
		rails generate devise:install
		rails g devise:views
		rails generate devise user
    rails generate devise:controllers users


    rails active_storage:install

rails g migration AddDetailsToUsers photo name

rails db:migrate

rails generate migration AddRoleToUsers role:integer //Agregando roles

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy  # Añade esta línea
  has_many :liked_posts, through: :likes, source: :post  # También debe estar presente

  enum role: { user: 0, moderator: 1, admin: 2 }

  before_create :set_default_role

  def set_default_role
    self.role ||= :user
  end
  
end


//Agregando CanCanCan

gem 'cancancan'
bundle install
rails g cancan:ability

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    case user.role
    when 'admin'
      can :manage, :all  # Los administradores pueden hacer todo
    when 'moderator'
      can :read, :all          # Los moderadores pueden leer todo
      can :update, Post
      can :create, Comment
    when 'user'
      can :read, :all          # Los moderadores pueden leer todo
      can :like, Post
      can :create, Comment      # Los moderadores pueden actualizar Post
    else
      can :read, Post          # Los usuarios regulares pueden leer Post
    end
  end
end

//agregar en los controladores los permisos asignados

 load_and_authorize_resource

// Manejo de errores al autenticar

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
end

// Utilización en las vistas para definir las funcionalidades que tendra cada rol

<% if can? :create, Post %>
  <%= link_to 'New Post', new_post_path %>
<% end %>
Vista Usuario Administrador, quien puede ver, agregar publicaciones, agregar y eliminar comentarios, dar like
<image src="/imagenes/1.jpeg" alt="Descripción de la imagen">
Vista Usuario Registrado, quien puede ver publicaciones, agregar  comentarios, dar like
<image src="/imagenes/3.jpeg" alt="Descripción de la imagen">
Vista Usuario sin registrarse, quien puede ver publicaciones
<image src="/imagenes/2.jpeg" alt="Descripción de la imagen">