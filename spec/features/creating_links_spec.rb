feature 'ability to add links' do
  scenario 'the user can add new links using a form' do
    visit '/new'
    expect(page.status_code).to eq 200
    fill_in 'url', with: 'www.englishtutorslive.com'
    fill_in 'title', with: 'ETL'
    click_button 'Submit'

    expect(current_path).to eq '/'

    within 'ul#links' do
      expect(page).to have_content 'ETL'
    end
  end
end
