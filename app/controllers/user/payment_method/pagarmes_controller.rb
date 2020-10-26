class User::PaymentMethod::PagarmesController < UserController
    before_action :pagarme, only: [:show, :edit, :update, :destroy]

  def index
    @pagarmes = current_user.user_profile.payment.payment_pagarmes
  end

  def show
  end

  def new
  end
  
  def edit    
  end

  def create    
    @pagarme = Payment::Pagarme.new(method_params.merge({payment_id: current_user.user_profile.payment.id}))
    if @pagarme.create_pagarme_credit_card
      @pagarme.default = false
      if @pagarme.save
        render :show, status: :created
      else
        render json: @pagarme.errors, status: :unprocessable_entity
      end
    else
      render json: @pagarme.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @pagarmes.update(method_params)
      render :show, status: :ok
    else
      render json: @pagarmes.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @pagarme.destroy      
      render json: {status => "success"}
    else
      render json: {status => "error"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def pagarme
      @pagarme = Payment::Pagarme.find_by(id: params[:id], payment_id: current_user.user_profile.payment.id)
    end

    def method_params
      params.require(:pagarme).permit(:card_number, :card_expiration_date, :card_holder_name, :payment_center_type, :card_cvv)
    end

end