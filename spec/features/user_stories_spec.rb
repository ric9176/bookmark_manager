feature "display a list of links" do
  scenario "the user is shown a list of links" do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit '/links'

    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end

feature "add a link" do
  scenario "the user is able to add links to the list" do
    visit '/links/new'
    fill_in('title', with: 'Google')
    fill_in('url', with: 'http://www.google.com')
    click_button('Create New')
    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
end

feature 'Adding tags' do
  scenario 'can add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.englishtutorslive.com'
    fill_in 'title', with: 'ETL'
    fill_in 'tags', with: 'education'

    click_button 'Create New'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end
end


feature 'Tagging things' do
  before(:each) do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])
    Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])
    Link.create(url: 'http://www.zombo.com', title: 'This is Zombocom', tags: [Tag.first_or_create(name: 'bubbles')])
    Link.create(url: 'http://www.bubble-bobble.com', title: 'Bubble Bobble', tags: [Tag.first_or_create(name: 'bubbles')])
  end


  scenario 'can view links that are tagged' do
    visit '/tag/bubbles'



    expect(page.status_code).to eq (200)
    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('Code.org')
      expect(page).to have_content('This is Zombocom')
      expect(page).to have_content('Bubble Bobble')
    end
  end
end

feature 'multiple tags' do
  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags', with: 'education ruby'
    click_button 'Create New'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end
end
