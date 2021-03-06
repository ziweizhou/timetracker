require 'spec_helper'

describe 'subdomains' do
  let!(:account) { create(:account_with_schema) }

  it 'redirect invalid accounts' do
    visit root_url(subdomain: 'randomname')
    expect(page.current_url).to_not include('randomname')
  end

  it 'allow valid accounts' do
    visit root_url(subdomain: account.subdomain)
    expect(page.current_url).to include(account.subdomain)
  end

  it 'forces user to login before accessing subdomain' do
    visit root_url(subdomain: account.subdomain)
    expect(page).to have_content 'sign in or sign up before continuing.'
  end
end
