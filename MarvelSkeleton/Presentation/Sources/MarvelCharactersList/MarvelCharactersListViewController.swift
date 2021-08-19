import UIKit

protocol MarvelCharactersListView: ViewProtocol {
    var presenter: MarvelCharactersListPresenterProtocol! { get set }

    func changeViewState(_ state: MarvelCharactersListViewState)
}

class MarvelCharactersListViewController: BaseViewController, MarvelCharactersListView {
    var presenter: MarvelCharactersListPresenterProtocol!
    private let cellIdentifire = "MarvelCharactersListTableViewCell"
    override static var storyboardName: String { "MarvelCharactersListView" }

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loaderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewWillAppear()
    }

    func changeViewState(_ state: MarvelCharactersListViewState) {
        hideUIViews()
        switch state {
        case .clear:
            break
        case .showLoader:
            loaderView.isHidden = false
        case .renderData:
            tableView.isHidden = false
            tableView.reloadData()
        case .showError:
            errorView.isHidden = false
        }
    }

    @IBAction func onTapRetryButton(_ sender: UIButton) {
        presenter.didTapOnRetryButton()
    }
}

private extension MarvelCharactersListViewController {
    func hideUIViews() {
        loaderView.isHidden = true
        tableView.isHidden = true
        errorView.isHidden = true
    }

    func setupHeader() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Marvel Characters List"
    }
}

extension MarvelCharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsForTableView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = presenter.viewModelForRow(row: indexPath.row) else {
            return UITableViewCell()
        }
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifire)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifire)
        }
        cell?.textLabel?.text = viewModel.name
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapOnTableRow(row: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
