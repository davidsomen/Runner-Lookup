import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIDocumentPickerDelegate
{
    fileprivate let kPrimaryColour = UIColor.white
    fileprivate let kSecondaryColour = UIColor(red: 0.0, green: 0.63, blue: 0.75, alpha: 1.0)
    fileprivate let kNotFoundColour = UIColor.red
    fileprivate let kCommentViewCornerRadius: CGFloat = 5
    fileprivate let kAnimationDuration = 0.3
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentView: UIView!
    
    var runnerList: RunnerList!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        commentView.layer.cornerRadius = kCommentViewCornerRadius
        
        runnerList = RunnerList()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        clear()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        load()
    }
    
    func showError(message: String)
    {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    func showImportMessage()
    {
        let message = String(runnerList.total) + " runners found"
        let alert = UIAlertController(title: "Load Succesful", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "GO!", style: .default)
        {
            alert in
            
            self.textField.becomeFirstResponder()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            textField.text = ""
            clear()
        }
        
        return Int(string) != nil && textField.text!.count < 4
    }
    
    @IBAction func textFieldChanged()
    {
        if let number = Int(textField.text!)
        {
            if let runner = runnerList.find(number)
            {
                textField.textColor = kSecondaryColour
                
                nameLabel.text = runner.name
                nameLabel.textColor = kPrimaryColour
                clubLabel.text = runner.club
                commentLabel.text = runner.comment
                
                animateView(view: nameLabel, text: runner.name)
                animateView(view: clubLabel, text: runner.club)
                animateView(view: commentView, text: runner.comment)
            
                return
            }
            else
            {
                textField.textColor = kNotFoundColour
            }
        }
        
        clear()
    }
    
    private func animateView(view: UIView, text: String)
    {
        //UIView.animate(withDuration: kAnimationDuration)
        //{
            view.isHidden = text.isEmpty
        //}
    }
    
    fileprivate func clear()
    {
        nameLabel.text = ""
        clubLabel.text = ""
        commentLabel.text = ""
        
        //UIView.animate(withDuration: kAnimationDuration)
        //{
            self.commentView.isHidden = true
            self.clubLabel.isHidden = true
        //}
    }
    
//    @IBAction func openButtonPressed(_ sender: Any)
//    {
//        let viewController = UIDocumentPickerViewController(documentTypes: ["public.comma-separated-values-text"], in: .import)
//        viewController.delegate = self
//
//        present(viewController, animated: true)
//    }
    
    func load()
    {
        do
        {
            try runnerList.load()
        }
        catch RunnerError.noRunnerData
        {
            showError(message: "The CSV file contains no runner data")
        }
        catch RunnerError.notNumber
        {
            showError(message: "The CSV file contains a runner with an invalid number")
        }
        catch RunnerError.notEnoughData
        {
            showError(message: "The CSV file does not contain enough data per runner")
        }
        catch RunnerError.fileNotFound
        {
            showError(message: "No CSV file named 'data' was found. Please connect to a computer and add the file using iTunes")
        }
        catch
        {
            showError(message: error.localizedDescription)
        }
        
        if runnerList != nil
        {
            showImportMessage()
        }
    }
}
