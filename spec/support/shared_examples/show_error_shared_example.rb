shared_examples "show error" do |message|
  it "redirects to Home page and shows error message" do
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to eq message
  end
end