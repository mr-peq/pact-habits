module ApplicationHelper
  def category_background_image(category)
    case category.downcase
    when 'walk'
      'https://images.unsplash.com/photo-1591175359422-f989eac13455?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    when 'hike'
      'https://images.unsplash.com/reserve/91JuTaUSKaMh2yjB1C4A_IMG_9284.jpg?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    when 'run'
      'https://images.unsplash.com/photo-1571008887538-b36bb32f4571?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    when 'cycle'
      'https://images.unsplash.com/photo-1523815378073-a43ae3fbf36a?q=80&w=3150&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    else
      'https://images.unsplash.com/photo-1565992441121-4367c2967103?q=80&w=2023&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    end
  end

  def beneficiary_image(beneficiary)
    case beneficiary.name.downcase
    when 'amnesty international'
      'https://www.amnesty.org/fr/wp-content/uploads/sites/8/2021/04/amnesty-international.jpeg'
    when 'medecins sans frontieres'
      'https://upload.wikimedia.org/wikipedia/fr/thumb/6/69/MSF.svg/1200px-MSF.svg.png'
    when 'action contre la faim'
      'https://entrevosmains.actioncontrelafaim.org/wp-content/themes/wext/assets/img/logo_acf.png'
    else
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Logo_of_UNICEF.svg/2560px-Logo_of_UNICEF.svg.png'
    end
  end
end
