import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    
    var note: Note? {
        didSet {
            print("chord did set")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
   
    func updateUI() {
        cellBackgroundView.layer.masksToBounds = false
        cellBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        cellBackgroundView.layer.shadowOpacity = 0.8
    }
}

extension MainCell: ReusableView { }
