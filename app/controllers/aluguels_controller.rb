class AluguelsController < ApplicationController
  before_action :set_aluguel, only: %i[ show edit update destroy ]
  before_action :authenticate_usuario!

  # GET /aluguels or /aluguels.json
  def index
    @a = Aluguel.ransack(params[:q])
    @aluguels = @a.result(distinct: true)
  end

  # GET /aluguels/1 or /aluguels/1.json
  def show
  end

  # GET /aluguels/new
  def new
    @aluguel = Aluguel.new
  end

  # GET /aluguels/1/edit
  def edit
  end

  # POST /aluguels or /aluguels.json
  def create
    @aluguel = Aluguel.new(aluguel_params)

    respond_to do |format|
      if @aluguel.save
        format.html { redirect_to aluguel_url(@aluguel), notice: "Aluguel was successfully created." }
        format.json { render :show, status: :created, location: @aluguel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @aluguel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aluguels/1 or /aluguels/1.json
  def update
    respond_to do |format|
      if @aluguel.update(aluguel_params)
        format.html { redirect_to aluguel_url(@aluguel), notice: "Aluguel was successfully updated." }
        format.json { render :show, status: :ok, location: @aluguel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @aluguel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aluguels/1 or /aluguels/1.json
  def destroy
    @aluguel.destroy

    respond_to do |format|
      format.html { redirect_to aluguels_url, notice: "Aluguel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_aluguel
    @aluguel = Aluguel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def aluguel_params
    params.require(:aluguel).permit(:cliente_id, :veiculo_id, :data_inicio, :data_fim, :valor_pago)
  end
end
