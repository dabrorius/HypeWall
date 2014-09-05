# resolves conflict with will-paginate, since activeadmin uses kaminari
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end