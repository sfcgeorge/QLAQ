Forem::Forum.class_eval do
  default_scope order('title ASC')
end