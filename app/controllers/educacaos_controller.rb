class EducacaosController < ApplicationController


  before_action :set_educacao, only: [:show, :edit, :update, :destroy]


  def lista
    @educacaos = Educacao.search(params[:search])
    #@educacaos = Educacao.where("nome like '%?%'", params[:nome]).page(params[:page]).order('created_at DESC')
    respond_to do |format|
        format.html
        format.json { render :json => @educacaos }
        format.xml { render :xml => @educacaos }
      end
  end

  # GET /educacaos
  # GET /educacaos.json
  def index
    @educacao = Educacao.new
    @educacaos = Educacao.all
    @modal = true

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
    educacao = Educacao.find(params[:id])
    ponto = educacao.the_geom
    @latitude = ponto.x
    @longitude = ponto.y

    respond_to do |format|
      format.html
      format.json {render json: educacao}
    end
  end

  # GET /educacaos/new
  def new
    @educacao = Educacao.new
  end

  # GET /educacaos/1/edit
  def edit
    @educacao = Educacao.find(params[:id])
    @modal = false
    respond_to do |format|
      format.html
      format.json
    end
  end

  # POST /educacaos
  # POST /educacaos.json
  def create
    @educacao = Educacao.new(educacao_params)

    respond_to do |format|
      if @educacao.save
        format.html { redirect_to educacaos_url, notice: 'Educacao was successfully created.' }
        format.json { render :json => @educacao }
      else
        #format.html { render action: 'new' }
        format.json { render json: @educacao.errors, status: :unprocessable_entity }
        format.js { render json: @educacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /educacaos/1
  # PATCH/PUT /educacaos/1.json
  def update
    respond_to do |format|
      if @educacao.update(educacao_params)
        format.html { redirect_to @educacao, notice: 'Educacao was successfully updated.' }
        format.json { render :json => @educacao }
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def educacao_params
      params.require(:educacao).permit(:nome, :email, :contato, :the_geom, :tipo, :diretor)
    end
end
