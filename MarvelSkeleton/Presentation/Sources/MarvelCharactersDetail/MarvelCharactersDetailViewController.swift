import UIKit
import SDWebImage

protocol MarvelCharactersDetailView: ViewProtocol {
    var presenter: MarvelCharactersDetailPresenterProtocol! { get set }

    func changeViewState(_ state: MarvelCharactersDetailViewState)
}

class MarvelCharactersDetailViewController: BaseViewController, MarvelCharactersDetailView {
    var presenter: MarvelCharactersDetailPresenterProtocol!
    override static var storyboardName: String { "MarvelCharactersDetailView" }

    @IBOutlet private weak var detailContainerView: UIView!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var comicsLabel: UILabel!
    @IBOutlet private weak var seriesLabel: UILabel!
    @IBOutlet private weak var storiesLabel: UILabel!
    @IBOutlet private weak var eventsLabel: UILabel!
    @IBOutlet private weak var copyrightLabel: UILabel!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loaderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewWillAppear()
    }

    func changeViewState(_ state: MarvelCharactersDetailViewState) {
        hideUIViews()
        switch state {
        case .clear:
            break
        case .showLoader:
            loaderView.isHidden = false
        case let .render(viewModel):
            renderViewModel(viewModel: viewModel)
        case .showError:
            errorView.isHidden = false
        }
    }

    @IBAction func onTapRetryButton(_ sender: UIButton) {
        presenter.didTapOnRetryButton()
    }
}

private extension MarvelCharactersDetailViewController {
    func hideUIViews() {
        loaderView.isHidden = true
        errorView.isHidden = true
    }

    func setupHeader() {
        navigationItem.title = "Marvel Character Details"
    }

    func renderViewModel(viewModel: MarvelCharactersDetailViewModel) {
        detailContainerView.isHidden = false
        let description = viewModel.description ?? ""
        nameLabel.text = viewModel.name
        descriptionLabel.text = description.isEmpty ? "Not Available" : description
        comicsLabel.text = "\(viewModel.availableComicsCount)"
        seriesLabel.text = "\(viewModel.availableSeriesCount)"
        storiesLabel.text = "\(viewModel.availableStoriesCount)"
        eventsLabel.text = "\(viewModel.availableEventsCount)"
        copyrightLabel.text = viewModel.copyrightLabel
        let imageUrl = viewModel.imageUrl + "." + viewModel.imageExtension
        characterImageView.sd_setImage(with: URL(string: imageUrl))
    }
}
