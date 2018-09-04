import UIKit

@IBDesignable
class RunnerTextField: UITextField
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height/2 - 3
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect
    {
        return CGRect.zero
    }
}
