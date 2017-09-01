# encoding: UTF-8

require 'bcrypt'

module Sip
  module Concerns
    module Controllers
      module UsuariosController

        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          before_action :set_usuario, only: [:show, :edit, :update, :destroy]

          def clase
            "::Usuario"
          end

          def atributos_index
            [ "id",
              "nusuario",
              "nombre",
              "descripcion",
              "rol",
              "email",
              "created_at_localizada"
            ]
          end

          def atributos_form
            r = [ 
              "nusuario",
              "nombre",
              "descripcion",
              "rol",
              "email",
            ]
            if can?(:manage, Sip::Grupo)
              r += ["sip_grupo"]
            end
            r += [
              "idioma",
              "encrypted_password",
              "fechacreacion_localizada",
              "fechadeshabilitacion_localizada",
              "failed_attempts",
              "unlock_token",
              "locked_at"
            ]
          end

          def index_reordenar(registros)
            registros.reorder('LOWER(nusuario)')
          end

          def new_modelo_path
            new_usuario_path()
          end

          def genclase
            'M'
          end

          # GET /usuarios
          # GET /usuarios.json
#          def index
#            authorize! :read, ::Usuario
#            @usuarios = ::Usuario.order('LOWER(nusuario)').paginate(
#              :page => params[:pagina], per_page: 20)
#            render 'sip/usuarios/index', layout: '/application'
#          end

          # GET /usuarios/1
          # GET /usuarios/1.json
#          def show
#            authorize! :read, ::Usuario
#            render 'sip/usuarios/show', layout: '/application'
#          end

          # GET /usuarios/new
#          def new
#            authorize! :edit, ::Usuario
#            @usuario = @registro = ::Usuario.new
#            @usuario.current_usuario = current_usuario
#            @usuario.fechacreacion = Date.today.to_s
#            super
#            #render 'sip/usuarios/new', layout: '/application'
#          end
#
#          # GET /usuarios/1/edit
#          def edit
#            authorize! :edit, ::Usuario
#            render 'sip/usuarios/edit', layout: '/application'
#          end
#
#          def create_gen(usuario)
#            usuario.encrypted_password = BCrypt::Password.create(
#              params[:usuario][:encrypted_password],
#              {:cost => Rails.application.config.devise.stretches})
#            respond_to do |format|
#              if usuario.save
#                format.html { redirect_to usuario, 
#                              notice: 'Usuario creado con éxito.' }
#                format.json { render 'sip/usuarios/show', 
#                              status: :created, location: usuario }
#              else
#                format.html { 
#                  render 'sip/usuarios/new' }
#                format.json { render json: usuario.errors, 
#                              status: :unprocessable_entity }
#              end
#            end
#          end
#
#
#          # POST /usuarios
#          # POST /usuarios.json
#          def create
#            authorize! :edit, ::Usuario
#            @usuario = ::Usuario.new(usuario_params)
#            create_gen(@usuario)
#          end
#
#          # PATCH/PUT /usuarios/1
#          # PATCH/PUT /usuarios/1.json
#          def update
#            authorize! :edit, ::Usuario
#            if (!params[:usuario][:encrypted_password].nil? &&
#                params[:usuario][:encrypted_password] != "")
#              params[:usuario][:encrypted_password] = BCrypt::Password.create(
#                params[:usuario][:encrypted_password],
#                {:cost => Rails.application.config.devise.stretches})
#            else
#              params[:usuario].delete(:encrypted_password)
#            end
#            respond_to do |format|
#              if @usuario.update(usuario_params)
#                format.html { redirect_to @usuario, notice: 'Usuario actualizado con éxito.' }
#                format.json { head :no_content }
#              else
#                format.html { render 'sip/usuarios/edit', 
#                              layout: '/application' }
#                format.json { render json: @usuario.errors, 
#                              status: :unprocessable_entity }
#              end
#            end
#          end
#
#          # DELETE /usuarios/1
#          # DELETE /usuarios/1.json
#          def destroy
#            authorize! :edit, ::Usuario
#            @usuario.destroy
#            respond_to do |format|
#              format.html { redirect_to usuarios_url }
#              format.json { head :no_content }
#            end
#          end

          private
         
          #  Configuración común
          def set_usuario
            @usuario = ::Usuario.find(params[:id])
            @usuario.current_usuario = current_usuario
          end

          def current_user
            current_usuario
          end

          # Lista blanca de paramétros
          def usuario_params
            p = params.require(:usuario).permit(
              :id, :nusuario, :password, 
              :nombre, :descripcion, :oficina_id,
              :rol, :idioma, :email, :encrypted_password, 
              :fechacreacion_localizada, :fechadeshabilitacion_localizada, 
              :reset_password_token, 
              :reset_password_sent_at, :remember_created_at, :sign_in_count, 
              :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, 
              :failed_attempts, :unlock_token, :locked_at,
              :last_sign_in_ip, :etiqueta_ids => []
            )
            return p
          end

        end  # included

      end
    end
  end
end

