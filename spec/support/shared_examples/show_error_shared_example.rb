shared_examples "show error" do |message|
  it "redirects to Home page and shows error message" do
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to eq message
  end
end

shared_examples "require signing in" do
  it "redirects to Sign in page" do
    expect(response).to redirect_to login_path
    expect(session[:previous_url]).to include previous_path
  end
end
