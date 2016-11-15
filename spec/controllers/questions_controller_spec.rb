require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before do
      get :index
    end

    it "get array of all questions" do
      expect(assigns(:questions)).to match_array questions
    end

    it "render index view" do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: question.id }, session: { user_id: question.user_id }
    end

    it "assign the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "render show view" do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before do
      get :new
    end

    it "assign the new question to @question" do
      expect(assigns :question).to be_a_new Question
    end

    it "render new view" do
      expect(response).to render_template :new
    end

  end

  describe 'GET #edit' do

    before do
      get :edit, params: { id: question.id }, session: { user_id: question.user_id }
    end

    it "assign the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "render show view" do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saved question in database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end
      it 'redirect to edit view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns :question)
      end
    end

    context 'with non valid attributes' do
      it 'not save question in database' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 're-renders new view ' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it "assign the requested question to @question" do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it "changes question attributes" do
        patch :update, params: { id: question, question: { title: "New Title", body: "New Long Body" } }
        question.reload
        expect(question.title).to eq "New Title"
        expect(question.body).to eq "New Long Body"
      end

      it "redirects to update question" do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns :question)
      end
    end

    context 'with non valid attributes' do
      before do
        patch :update, params: { id: question, question: { title: "New Title", body: nil } }
      end

      it "does not changed questions attributes" do
        question.reload
        expect(question.title).to eq "MySomeString"
        expect(question.body).to eq "MySomeText"
      end

      it "re-render update question" do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      question
    end

    it 'deletes question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it 'render to index' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
