import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    
    var chord: Chord? {
        didSet {
            print("chord did set")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(true, animated: true)
      
    }
   
    func updateUI() {
        cellBackgroundView.layer.masksToBounds = false
        
        cellBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        cellBackgroundView.layer.shadowOpacity = 0.8
    }
 
}

extension MainCell: ReusableView { }
