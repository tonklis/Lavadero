feature 'FeedbacksController' do

  let!(:order_01){create(:order)}
  
  let!(:question_01){create(:question, question_type: "RATE", root: true)}
  let!(:question_02){create(:question, question_type: "SINGLE")}
  let!(:question_03){create(:question, question_type: "MULTIPLE")}
  let!(:question_04){create(:question, question_type: "MULTIPLE")}

  let!(:answer_01){create(:answer, parent_question: question_01, child_question: question_02)}
  let!(:answer_02){create(:answer, parent_question: question_01)}
  let!(:answer_03){create(:answer, parent_question: question_02, child_question: question_03)}
  let!(:answer_04){create(:answer, parent_question: question_02, child_question: question_04)}
  let!(:answer_05){create(:answer, parent_question: question_03)}
  let!(:answer_06){create(:answer, parent_question: question_04)}

  context 'create batch feedbacks' do

    it 'should create many feedback objects' do
      
      feedbacks = [{order_id: order_01.id, answer_id: answer_01.id},
                   {order_id: order_01.id, answer_id: answer_03.id},
                   {order_id: order_01.id, answer_id: answer_05.id, description: "last in tree"}]

      with_rack_test_driver do
        page.driver.post batch_create_feedbacks_path, { feedbacks: feedbacks}
      end
      response = JSON.parse(page.body)
      expect(response["feedbacks"].count).to be 3
      expect(response["feedbacks"][2]["description"]).to eql "last in tree"

    end

  end
end
