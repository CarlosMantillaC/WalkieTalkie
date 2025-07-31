//
//  ChannelViewController.swift
//  WalkieTalkie
//

//
import UIKit

class ChannelViewController: UIViewController {
    
    var presenter: ChannelPresenterProtocol?
    private var gradientLayer: CAGradientLayer?
    private var fetchUsersTimer: Timer?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameChannelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameChannelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let countUsersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let disconnectButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let image = UIImage(systemName: "power", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let talkToPushButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .red
        config.cornerStyle = .capsule
        config.image = UIImage(
            systemName: "mic.slash.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        )
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        
        let button = UIButton(configuration: config)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        applyTalkButtonImage(isTalking: false)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cerrar sesión",
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradientBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startUserFetchTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopUserFetchTimer()
    }
    
    @objc private func didTapLogout() {
        presenter?.didTapLogout()
    }
    
    @objc private func didTapExit() {
        presenter?.didTapExit()
    }
    
    @objc private func talkButtonPressed() {
        presenter?.startTalking()
        applyTalkButtonImage(isTalking: true)
        talkToPushButton.backgroundColor = .clear
    }
    
    @objc private func talkButtonReleased() {
        presenter?.stopTalking()
        applyTalkButtonImage(isTalking: false)
        talkToPushButton.backgroundColor = .clear
    }
    
    @objc private func didTapDropdown() {
        presenter?.didTapDropdown()
    }
    
    private func startUserFetchTimer() {
        guard fetchUsersTimer == nil else { return }
        
        fetchUsersTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.presenter?.refreshUsers()
        }
        RunLoop.main.add(fetchUsersTimer!, forMode: .common)
    }
    
    private func stopUserFetchTimer() {
        fetchUsersTimer?.invalidate()
        fetchUsersTimer = nil
    }
}

extension ChannelViewController {
    private func setupUI() {
        view.backgroundColor = .black
        
        setupScrollView()
        setupInfoContainer()
        setupTalkButton()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupInfoContainer() {
        contentView.addSubview(infoContainerView)
        infoContainerView.addSubview(nameChannelStackView)
        nameChannelStackView.addArrangedSubview(nameChannelLabel)
        nameChannelStackView.addArrangedSubview(dropdownButton)
        infoContainerView.addSubview(countUsersLabel)
        infoContainerView.addSubview(disconnectButton)
        
        NSLayoutConstraint.activate([
            infoContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            infoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nameChannelStackView.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 30),
            nameChannelStackView.centerXAnchor.constraint(equalTo: infoContainerView.centerXAnchor),
            
            countUsersLabel.topAnchor.constraint(equalTo: nameChannelLabel.bottomAnchor, constant: 24),
            countUsersLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 24),
            countUsersLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -12),
            countUsersLabel.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -30),
            
            disconnectButton.centerYAnchor.constraint(equalTo: countUsersLabel.centerYAnchor),
            disconnectButton.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -20),
            disconnectButton.widthAnchor.constraint(equalToConstant: 24),
            disconnectButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        disconnectButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        dropdownButton.addTarget(self, action: #selector(didTapDropdown), for: .touchUpInside)
    }
    
    private func setupTalkButton() {
        contentView.addSubview(talkToPushButton)
        
        NSLayoutConstraint.activate([
            talkToPushButton.topAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: 160),
            talkToPushButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            talkToPushButton.widthAnchor.constraint(equalToConstant: 120),
            talkToPushButton.heightAnchor.constraint(equalToConstant: 120),
            talkToPushButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40)
        ])
        
        talkToPushButton.addTarget(self, action: #selector(talkButtonPressed), for: .touchDown)
        talkToPushButton.addTarget(self, action: #selector(talkButtonReleased), for: [.touchUpInside, .touchUpOutside])
    }
    
    private func applyTalkButtonImage(isTalking: Bool) {
        let iconName = isTalking ? "mic.fill" : "mic.slash.fill"
        let color: UIColor = isTalking ? .systemGreen : .systemRed
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        talkToPushButton.configuration?.image = UIImage(systemName: iconName, withConfiguration: imageConfig)
        talkToPushButton.configuration?.baseForegroundColor = color
        talkToPushButton.layer.borderColor = color.cgColor
        
    }
}

extension ChannelViewController: ChannelViewProtocol {
    func setChannelName(_ name: String) {
        DispatchQueue.main.async {
            self.nameChannelLabel.text = name
            let isConnected = name != "Desconectado"
            self.disconnectButton.isHidden = !isConnected
            self.talkToPushButton.isHidden = !isConnected
            self.countUsersLabel.isHidden = !isConnected
            
            if isConnected {
                self.startUserFetchTimer()
            } else {
                self.stopUserFetchTimer()
            }
        }
    }
    
    func displayUsers(_ emails: [String]) {
        let count = emails.count
        DispatchQueue.main.async {
            self.countUsersLabel.text = "\(count) conectados"
        }
    }
}
