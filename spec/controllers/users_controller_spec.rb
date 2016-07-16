feature 'UsersController' do

  let!(:user_01){create(:user)}

  context 'login' do

    it 'should sign in and get session' do
      
      page = login_with_service user = { nickname: user_01.nickname, password: "12345678" }
      access_token_1, uid_1, client_1, expiry_1, token_type_1 = get_headers
      set_headers access_token_1, uid_1, client_1, expiry_1, token_type_1
      
      response = JSON.parse(page.body)      
      expect(response["user"]["id"]).to eql user_01.id

      page = get_session 
      response = JSON.parse(page.body)
      expect(response["user"]["id"]).to eql user_01.id
      
    end

    it 'should not let it login with incorrect password' do

      page = login_with_service user = { nickname: user_01.nickname, password: "123456789" }
      
      response = JSON.parse(page.body)
      expect(response["errors"][0]["title"]).to eql "El correo electrónico o la contraseña son incorrectos."
      expect(page.status_code).to be 500

    end

  end

end
