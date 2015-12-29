
feature "display a list of links" do
  scenario "the user is shown a list of links" do
    Link.create(url: 'http://whatevs.com', title: 'Makers Academy')

    visit '/'

    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end
