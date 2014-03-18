class EducacaosController < ApplicationController
  before_action :set_educacao, only: [:show, :edit, :update, :destroy]



  # GET /educacaos
  # GET /educacaos.json
  def index
    @educacao = Educacao.new
    @educacaos = Educacao.all

     factory = RGeo::GeoJSON::EntityFactory.instance
     features = []
     @educacaos.each do |edu|
       feature = factory.feature(edu.the_geom, nil, {id: edu.id, nome: edu.nome, email: edu.email, contato: edu.contato})
       features << feature
     end

     json_edu = RGeo::GeoJSON.encode factory.feature_collection(features)

      respond_to do |format|
        format.html
        format.json { render :json => json_edu }
        format.xml { render :xml => @educacaos }
      end
  end

  # GET /educacaos/1
  # GET /educacaos/1.json
  def show
  end

  # GET /educacaos/new
  def new
    @educacao = Educacao.new
  end

  # GET /educacaos/1/edit
  def edit
  end

  # POST /educacaos
  # POST /educacaos.json
  def create
    @educacao = Educacao.new(educacao_params)
    #the_geom = Educacao.find(params[:the_geom])
    #puts the_geom

    respond_to do |format|
      if @educacao.save
        format.html { redirect_to educacaos_url, notice: 'Educacao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @educacao }
      else
        format.html { render action: 'new' }
        format.json { render json: @educacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /educacaos/1
  # PATCH/PUT /educacaos/1.json
  def update
    respond_to do |format|
      if @educacao.update(educacao_params)
        format.html { redirect_to @educacao, notice: 'Educacao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @educacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /educacaos/1
  # DELETE /educacaos/1.json
  def destroy
    @educacao.destroy
    respond_to do |format|
      format.html { redirect_to educacaos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_educacao
      @educacao = Educacao.find(params[:id])
      #@educacao.update_attributes(params[:wkt])
      #@educacao.the_geom = Educacao.find(params[:dados])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def educacao_params
      params.require(:educacao).permit(:nome, :email, :contato, :the_geom)
    end
end
