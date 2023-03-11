
import UIKit

class NotesVC : UIViewController {
    
    let viewModel = NoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        viewModel.getData { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                // Handle the error
                print("error \(error)")
            }
        }
    }
}

