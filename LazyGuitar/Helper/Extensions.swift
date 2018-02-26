import UIKit

extension UITableView {
    
    func displayEmptyTableViewMessage() {
        let frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        let messageLabel = UILabel(frame: frame)
        messageLabel.text = "There are no notes to show 😩\n Use the button at the top to create one!"
        messageLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func dequeReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionView {
    func dequeReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension Date {
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: self as Date)
    }
    
    func mediumStyleDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self as Date)
    }
}

extension UIColor {
    class func themeColor() -> UIColor {
        return UIColor(red: 0.761, green: 0.256, blue: 0.0, alpha: 1.0)
    }
}
