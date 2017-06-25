module ApplicationHelper
  def current_user_img
    current_user.avatar ? image_tag(current_user.avatar, height: 36, width: 36,
                         style: 'vertical-align: sub', class: 'circle') : image_tag('http://vipei.ca/img/default_avatar.jpg', height: 36, width: 36,
                         style: 'vertical-align: sub', class: 'circle')
  end
end
