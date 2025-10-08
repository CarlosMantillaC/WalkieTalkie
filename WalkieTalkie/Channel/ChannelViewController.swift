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
    private let soundService = SoundButtonService()
    
    private let generalInfoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private let infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private let nameChannelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
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
        var config = UIButton.Configuration.filled()
        config.title = "Desconectar"
        config.baseBackgroundColor = UIColor(red: 75/255.0, green: 0/255.0, blue: 130/255.0, alpha: 1.0)
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let changeChannelButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Cambiar"
        config.baseBackgroundColor = UIColor(red: 75/255.0, green: 0/255.0, blue: 130/255.0, alpha: 1.0)
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let talkToPushButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .red
        config.cornerStyle = .capsule
        config.image = UIImage(
            systemName: "mic.slash.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        )

        let button = UIButton(configuration: config)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
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
        soundService.playSound(named: "audio_start_talking.mp3")
    }
    
    @objc private func talkButtonReleased() {
        presenter?.stopTalking()
        applyTalkButtonImage(isTalking: false)
        talkToPushButton.backgroundColor = .clear
        soundService.playSound(named: "audio_end_talking.mp3")
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
        contentView.addSubview(generalInfoContainerView)
        generalInfoContainerView.addSubview(infoContainerView)
        generalInfoContainerView.addSubview(disconnectButton)
        generalInfoContainerView.addSubview(changeChannelButton)
        infoContainerView.addSubview(nameChannelStackView)
        infoContainerView.addSubview(countUsersLabel)
        nameChannelStackView.addArrangedSubview(nameChannelLabel)
        nameChannelStackView.addArrangedSubview(dropdownButton)
        
        NSLayoutConstraint.activate([
            generalInfoContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            generalInfoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            generalInfoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            generalInfoContainerView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: 90),

            infoContainerView.topAnchor.constraint(equalTo: generalInfoContainerView.topAnchor, constant: 30),
            infoContainerView.leadingAnchor.constraint(equalTo: generalInfoContainerView.leadingAnchor, constant: 40),
            infoContainerView.trailingAnchor.constraint(equalTo: generalInfoContainerView.trailingAnchor, constant: -40),
            
            nameChannelStackView.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 30),
            nameChannelStackView.centerXAnchor.constraint(equalTo: infoContainerView.centerXAnchor),
            
            countUsersLabel.topAnchor.constraint(equalTo: nameChannelLabel.bottomAnchor, constant: 24),
            countUsersLabel.centerXAnchor.constraint(equalTo: infoContainerView.centerXAnchor),
            countUsersLabel.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -30),
            
            disconnectButton.bottomAnchor.constraint(equalTo: generalInfoContainerView.bottomAnchor, constant: -30),
            disconnectButton.trailingAnchor.constraint(equalTo: generalInfoContainerView.trailingAnchor, constant: -40),

            changeChannelButton.bottomAnchor.constraint(equalTo: generalInfoContainerView.bottomAnchor, constant: -30),
            changeChannelButton.leadingAnchor.constraint(equalTo: generalInfoContainerView.leadingAnchor, constant: 40)
        ])
        
        disconnectButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        dropdownButton.addTarget(self, action: #selector(didTapDropdown), for: .touchUpInside)
        changeChannelButton.addTarget(self, action: #selector(didTapDropdown), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDropdown))
        nameChannelStackView.isUserInteractionEnabled = true
        nameChannelStackView.addGestureRecognizer(tapGesture)
    }
    
    private func setupTalkButton() {
        contentView.addSubview(talkToPushButton)
        
        NSLayoutConstraint.activate([
            talkToPushButton.topAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: 340),
            talkToPushButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            talkToPushButton.widthAnchor.constraint(equalToConstant: 200),
            talkToPushButton.heightAnchor.constraint(equalToConstant: 200),
            talkToPushButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40)
        ])
        
        talkToPushButton.addTarget(self, action: #selector(talkButtonPressed), for: .touchDown)
        talkToPushButton.addTarget(self, action: #selector(talkButtonReleased), for: .touchUpInside)
    }
    
    private func applyTalkButtonImage(isTalking: Bool) {
        let iconName = isTalking ? "mic.fill" : "mic.slash.fill"
        let textName = isTalking ? "Hablando..." : "Pulsa para hablar"
        let color: UIColor = isTalking ? .systemGreen : .systemRed
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        talkToPushButton.configuration?.image = UIImage(systemName: iconName, withConfiguration: imageConfig)
        
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 24)
         
        talkToPushButton.configuration?.attributedTitle = AttributedString(textName, attributes: container)
        talkToPushButton.configuration?.baseForegroundColor = color
        talkToPushButton.layer.borderColor = color.cgColor
        talkToPushButton.configuration?.imagePlacement = .top
        talkToPushButton.configuration?.imagePadding = 10
        talkToPushButton.configuration?.titleAlignment = .center
    }
}

extension ChannelViewController: ChannelViewProtocol {
    func setChannelName(_ name: String) {
        nameChannelLabel.text = name
    }
    
    func displayUsers(_ text: String) {
        DispatchQueue.main.async {
            self.countUsersLabel.text = text
        }
    }
    
    func showDisconnectedState() {
        nameChannelLabel.text = "Desconectado"
        disconnectButton.isHidden = true
        talkToPushButton.isHidden = true
        countUsersLabel.isHidden = true
        changeChannelButton.isHidden = true
        stopUserFetchTimer()
    }
}

