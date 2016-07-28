# encoding: utf-8
require 'browser_test_helper'

class PreferencesTest < TestCase
  def test_permission_agent
    @browser = browser_instance
    login(
      username: 'master@example.com',
      password: 'test',
      url: browser_url,
    )
    click(css: 'a[href="#current_user"]')
    click(css: 'a[href="#profile"]')
    match(
      css: '.content .NavBarProfile',
      value: 'Password',
    )
    match(
      css: '.content .NavBarProfile',
      value: 'Language',
    )
    match(
      css: '.content .NavBarProfile',
      value: 'Notifications',
    )
    match(
      css: '.content .NavBarProfile',
      value: 'Calendar',
    )
    match(
      css: '.content .NavBarProfile',
      value: 'Token Access',
    )
  end

  def test_permission_customer
    @browser = browser_instance
    login(
      username: 'nicole.braun@zammad.org',
      password: 'test',
      url: browser_url,
    )
    click(css: 'a[href="#current_user"]')
    click(css: 'a[href="#profile"]')
    match(
      css: '.content .NavBarProfile',
      value: 'Password',
    )
    match(
      css: '.content .NavBarProfile',
      value: 'Language',
    )
    match_not(
      css: '.content .NavBarProfile',
      value: 'Notifications',
    )
    match_not(
      css: '.content .NavBarProfile',
      value: 'Calendar',
    )
    match_not(
      css: '.content .NavBarProfile',
      value: 'Token Access',
    )
  end

  def test_lang_change
    @browser = browser_instance
    login(
      username: 'master@example.com',
      password: 'test',
      url: browser_url,
    )
    tasks_close_all()

    # start ticket create
    ticket_create(
      data: {
        customer: 'nicole',
        group: 'Users',
        title: 'preferences lang check #1',
        body: 'preferences lang check #1',
      },
      do_not_submit: true,
    )

    # start ticket zoom
    ticket_create(
      data: {
        customer: 'nicole',
        group: 'Users',
        title: 'preferences lang check #2',
        body: 'preferences lang check #2',
      },
    )

    # start user profile
    user_open_by_search(
      value: 'Nicole',
    )

    # start organization profile
    organization_open_by_search(
      value: 'Zammad Foundation',
    )

    click(css: 'a[href="#current_user"]')
    click(css: 'a[href="#profile"]')
    click(css: 'a[href="#profile/language"]')
    select(
      css: '.language_item [name="locale"]',
      value: 'Deutsch',
    )
    click(css: '.content button[type="submit"]')
    watch_for(
      css: 'body',
      value: 'Sprache',
    )

    # check language in navbar
    watch_for(
      css: '.js-menu',
      value: 'Übersicht'
    )

    # check language in dashboard
    click(css: '.js-menu a[href="#dashboard"]')
    watch_for(
      css: '.content.active',
      value: 'Meine Statistik'
    )

    # check language in overview
    click(css: '.js-menu a[href="#ticket/view"]')
    watch_for(
      css: '.content.active',
      value: 'Meine'
    )
    verify_title(
      value: 'Meine zugewiesenen',
    )

    # check language in ticket create
    open_task(
      data: {
        title: 'Anruf',
      }
    )
    verify_task(
      data: {
        title: 'Anruf',
      }
    )
    open_task(
      data: {
        title: 'preferences lang check #1',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'kunde'
    )
    watch_for(
      css: '.content.active',
      value: 'priorität'
    )
    watch_for(
      css: '.content.active [data-name="body"]',
      value: 'preferences lang check #1'
    )
    verify_title(
      value: 'anruf',
    )

    # check language in ticket zoom
    open_task(
      data: {
        title: 'preferences lang check #2',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'erstellt'
    )
    watch_for(
      css: '.content.active',
      value: 'priorität'
    )

    # check language in user profile
    open_task(
      data: {
        title: 'Nicole',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'notiz'
    )
    watch_for(
      css: '.content.active',
      value: 'e-mail'
    )
    watch_for(
      css: '.content.active',
      value: 'aktion'
    )

    # check language in organization profile
    open_task(
      data: {
        title: 'Zammad',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'notiz'
    )

    click(css: 'a[href="#current_user"]')
    click(css: 'a[href="#profile"]')
    click(css: 'a[href="#profile/language"]')
    select(
      css: '.language_item [name="locale"]',
      value: 'English (United States)',
    )
    click(css: '.content button[type="submit"]')
    sleep 2
    watch_for(
      css: 'body',
      value: 'Language',
    )

    # check language in navbar
    watch_for(
      css: '.js-menu',
      value: 'Overview'
    )

    # check language in dashboard
    click(css: '.js-menu a[href="#dashboard"]')
    watch_for(
      css: '.content.active',
      value: 'My Stats'
    )

    # check language in overview
    click(css: '.js-menu a[href="#ticket/view"]')
    watch_for(
      css: '.content.active',
      value: 'My'
    )
    verify_title(
      value: 'My assig',
    )

    # check language in ticket create
    open_task(
      data: {
        title: 'Call',
      }
    )
    verify_task(
      data: {
        title: 'Call',
      }
    )
    open_task(
      data: {
        title: 'preferences lang check #1',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'customer'
    )
    watch_for(
      css: '.content.active',
      value: 'priority'
    )
    watch_for(
      css: '.content.active [data-name="body"]',
      value: 'preferences lang check #1'
    )
    verify_title(
      value: 'call',
    )

    # check language in ticket zoom
    open_task(
      data: {
        title: 'preferences lang check #2',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'create'
    )
    watch_for(
      css: '.content.active',
      value: 'priority'
    )

    # check language in user profile
    open_task(
      data: {
        title: 'Nicole',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'note'
    )
    watch_for(
      css: '.content.active',
      value: 'email'
    )

    # check language in organization profile
    open_task(
      data: {
        title: 'Zammad',
      }
    )
    watch_for(
      css: '.content.active',
      value: 'note'
    )
    watch_for(
      css: '.content.active',
      value: 'action'
    )

    # switch to de again
    click(css: 'a[href="#current_user"]')
    click(css: 'a[href="#profile"]')
    click(css: 'a[href="#profile/language"]')
    sleep 4
    select(
      css: '.language_item [name="locale"]',
      value: 'Deutsch',
    )
    click(css: '.content button[type="submit"]')
    sleep 4
    watch_for(
      css: 'body',
      value: 'Sprache',
    )
    sleep 6

    # check if language is still used after reload
    reload()
    sleep 2

    watch_for(
      css: 'body',
      value: 'Sprache',
    )

    # check language in navbar
    watch_for(
      css: '.js-menu',
      value: 'Übersicht'
    )

    # check language in dashboard
    click(css: '.js-menu a[href="#dashboard"]')
    watch_for(
      css: '.content.active',
      value: 'Meine Statistik'
    )

    # check language in overview
    click(css: '.js-menu a[href="#ticket/view"]')
    watch_for(
      css: '.content.active',
      value: 'Meine'
    )
  end

  def test_token_access
    @browser = browser_instance
    login(
      username: 'agent1@example.com',
      password: 'test',
      url: browser_url,
    )
    tasks_close_all()
    click(css: 'a[href="#current_user"]')
    click(css: 'a[href="#profile"]')
    click(css: 'a[href="#profile/token_access"]')

    set(
      css:   '#content .js-create .js-input',
      value: 'Some App#1',
    )
    click(css: '#content .js-create .js-submit')
    watch_for(
      css: '.modal .modal-title',
      value: 'Your New Personal Access Token'
    )
    click(css: '.modal .js-submit')
    watch_for(
      css: '#content .js-tokenList',
      value: 'Some App#1'
    )

    set(
      css:   '#content .js-create .js-input',
      value: 'Some App#2',
    )
    click(css: '#content .js-create .js-submit')
    watch_for(
      css: '.modal .modal-title',
      value: 'Your New Personal Access Token'
    )
    click(css: '.modal .js-submit')
    watch_for(
      css: '#content .js-tokenList',
      value: 'Some App#2'
    )

    click(css: '#content .js-tokenList a')
    sleep 1
    alert = @browser.switch_to.alert
    alert.accept()
    watch_for_disappear(
      css: '#content .js-tokenList',
      value: 'Some App#2'
    )

  end
end
