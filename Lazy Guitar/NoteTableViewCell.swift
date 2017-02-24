import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noteBackground: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateContainer: UIView!
    
    var title: Title! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        
        noteBackground.backgroundColor = .white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        noteBackground.layer.cornerRadius = 3.0
        noteBackground.layer.masksToBounds = false
        
        noteBackground.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        noteBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
        noteBackground.layer.shadowOpacity = 0.8

    }
}
