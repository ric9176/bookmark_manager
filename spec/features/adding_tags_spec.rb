feature 'Adding tags' do
  scenario 'I can add a single tag to a new link' do
    visit '/new'
    fill_in 'url', with: 'www.englishtutorslive.com'
    fill_in 'title', with: 'ETL'
    fill_in 'tags', with: 'education ruby'

    click_button 'Submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end
end
