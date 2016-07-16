feature 'BookingsController' do

  let!(:user_01){create(:user)}

  context 'get bookings' do

    it 'should sign in and get bookings' do
      
      page = login_with_service user = { nickname: user_01.nickname, password: "12345678" }
      access_token_1, uid_1, client_1, expiry_1, token_type_1 = get_headers
      set_headers access_token_1, uid_1, client_1, expiry_1, token_type_1
      
      response = JSON.parse(page.body)      
      expect(response["user"]["id"]).to eql user_01.id
      
      visit bookings_in_the_future_by_courier_path
      response = JSON.parse(page.body)
      expect(page.status_code).to be 200
      
    end

    it 'should not get anything if user is not logged in' do

      visit bookings_in_the_future_by_courier_path
      response = JSON.parse(page.body)
      expect(page.status_code).to be 401

    end

  end

end
