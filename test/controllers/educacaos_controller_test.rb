require 'test_helper'

class EducacaosControllerTest < ActionController::TestCase
  setup do
    @educacao = educacaos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:educacaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create educacao" do
    assert_difference('Educacao.count') do
      post :create, educacao: { contato: @educacao.contato, email: @educacao.email, nome: @educacao.nome, the_geom: @educacao.the_geom }
    end

    assert_redirected_to educacao_path(assigns(:educacao))
  end

  test "should show educacao" do
    get :show, id: @educacao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @educacao
    assert_response :success
  end

  test "should update educacao" do
    patch :update, id: @educacao, educacao: { contato: @educacao.contato, email: @educacao.email, nome: @educacao.nome, the_geom: @educacao.the_geom }
    assert_redirected_to educacao_path(assigns(:educacao))
  end

  test "should destroy educacao" do
    assert_difference('Educacao.count', -1) do
      delete :destroy, id: @educacao
    end

    assert_redirected_to educacaos_path
  end
end
