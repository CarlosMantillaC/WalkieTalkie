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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let nameChannelLabelContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        container.layer.cornerRadius = 10
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false

        return container
    }()
    
    private let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityLabel = "Cambiar canal"
        button.accessibilityHint = "Muestra la lista de canales"

        return button
    }()
    
    private let nameChannelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    private let countUsersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let countUsersLabelContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        container.layer.cornerRadius = 10
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false

        return container
    }()
    
    private let countUsersDropdownButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityLabel = "Ver usuarios"
        button.accessibilityHint = "Muestra la lista de usuarios conectados"

        return button
    }()
    
    private let countUsersStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
    
        return stack
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
    
    private let talkButtonContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        container.layer.cornerRadius = 20
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false

        return container
    }()
    
    private let disconnectedInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Desconectado, selecciona un canal"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true

        return label
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

    @objc private func didTapDropdownCountUser() {
        presenter?.didTapDropdownCountUser()
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
        infoContainerView.addSubview(countUsersStackView)
        nameChannelLabelContainer.addSubview(nameChannelLabel)
        countUsersLabelContainer.addSubview(countUsersLabel)

        NSLayoutConstraint.activate([
            nameChannelLabel.topAnchor.constraint(equalTo: nameChannelLabelContainer.topAnchor, constant: 12),
            nameChannelLabel.leadingAnchor.constraint(equalTo: nameChannelLabelContainer.leadingAnchor, constant: 16),
            nameChannelLabel.trailingAnchor.constraint(equalTo: nameChannelLabelContainer.trailingAnchor, constant: -16),
            nameChannelLabel.bottomAnchor.constraint(equalTo: nameChannelLabelContainer.bottomAnchor, constant: -12)
        ])
        
        nameChannelStackView.addArrangedSubview(nameChannelLabelContainer)
        nameChannelStackView.addArrangedSubview(dropdownButton)

        nameChannelLabelContainer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        nameChannelLabelContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        dropdownButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        dropdownButton.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            countUsersLabel.topAnchor.constraint(equalTo: countUsersLabelContainer.topAnchor, constant: 12),
            countUsersLabel.leadingAnchor.constraint(equalTo: countUsersLabelContainer.leadingAnchor, constant: 16),
            countUsersLabel.trailingAnchor.constraint(equalTo: countUsersLabelContainer.trailingAnchor, constant: -16),
            countUsersLabel.bottomAnchor.constraint(equalTo: countUsersLabelContainer.bottomAnchor, constant: -12)
        ])
        
        countUsersStackView.addArrangedSubview(countUsersLabelContainer)
        countUsersStackView.addArrangedSubview(countUsersDropdownButton)
        
        countUsersLabelContainer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        countUsersLabelContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        countUsersDropdownButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        countUsersDropdownButton.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            generalInfoContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            generalInfoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            generalInfoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            generalInfoContainerView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: 90),

            infoContainerView.topAnchor.constraint(equalTo: generalInfoContainerView.topAnchor, constant: 30),
            infoContainerView.leadingAnchor.constraint(equalTo: generalInfoContainerView.leadingAnchor, constant: 40),
            infoContainerView.trailingAnchor.constraint(equalTo: generalInfoContainerView.trailingAnchor, constant: -40),
            
            nameChannelStackView.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 30),
            nameChannelStackView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 20),
            nameChannelStackView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -20),
            nameChannelStackView.centerXAnchor.constraint(equalTo: infoContainerView.centerXAnchor),
            
            countUsersStackView.topAnchor.constraint(equalTo: nameChannelStackView.bottomAnchor, constant: 24),
            countUsersStackView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 20),
            countUsersStackView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -20),
            countUsersStackView.centerXAnchor.constraint(equalTo: infoContainerView.centerXAnchor),
            countUsersStackView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -30),
            
            disconnectButton.bottomAnchor.constraint(equalTo: generalInfoContainerView.bottomAnchor, constant: -30),
            disconnectButton.trailingAnchor.constraint(equalTo: generalInfoContainerView.trailingAnchor, constant: -40),

            changeChannelButton.bottomAnchor.constraint(equalTo: generalInfoContainerView.bottomAnchor, constant: -30),
            changeChannelButton.leadingAnchor.constraint(equalTo: generalInfoContainerView.leadingAnchor, constant: 40)
        ])
        
        disconnectButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        dropdownButton.addTarget(self, action: #selector(didTapDropdown), for: .touchUpInside)
        changeChannelButton.addTarget(self, action: #selector(didTapDropdown), for: .touchUpInside)
        countUsersDropdownButton.addTarget(self, action: #selector(didTapDropdownCountUser), for: .touchUpInside)
        
        let tapGestureName = UITapGestureRecognizer(target: self, action: #selector(didTapDropdown))
        nameChannelStackView.isUserInteractionEnabled = true
        nameChannelStackView.addGestureRecognizer(tapGestureName)
        
        let tapGestureUsers = UITapGestureRecognizer(target: self, action: #selector(didTapDropdown))
        countUsersStackView.isUserInteractionEnabled = true
        countUsersStackView.addGestureRecognizer(tapGestureUsers)
    }
    
    private func setupTalkButton() {
        contentView.addSubview(talkButtonContainer)
        talkButtonContainer.addSubview(talkToPushButton)
        talkButtonContainer.addSubview(disconnectedInfoLabel)
        
        NSLayoutConstraint.activate([
            talkButtonContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            talkButtonContainer.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 40),
            talkButtonContainer.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -40),
            talkButtonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])

        let minTopSpacing = talkButtonContainer.topAnchor.constraint(greaterThanOrEqualTo: infoContainerView.bottomAnchor, constant: 99)
        minTopSpacing.priority = .defaultHigh
        minTopSpacing.isActive = true

        NSLayoutConstraint.activate([
            talkToPushButton.topAnchor.constraint(equalTo: talkButtonContainer.topAnchor, constant: 20),
            talkToPushButton.leadingAnchor.constraint(equalTo: talkButtonContainer.leadingAnchor, constant: 20),
            talkToPushButton.trailingAnchor.constraint(equalTo: talkButtonContainer.trailingAnchor, constant: -20),
            talkToPushButton.bottomAnchor.constraint(equalTo: talkButtonContainer.bottomAnchor, constant: -20),
            talkToPushButton.widthAnchor.constraint(equalToConstant: 160),
            talkToPushButton.heightAnchor.constraint(equalToConstant: 160),
            talkButtonContainer.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            disconnectedInfoLabel.topAnchor.constraint(equalTo: talkButtonContainer.topAnchor, constant: 16),
            disconnectedInfoLabel.leadingAnchor.constraint(equalTo: talkButtonContainer.leadingAnchor, constant: 16),
            disconnectedInfoLabel.trailingAnchor.constraint(equalTo: talkButtonContainer.trailingAnchor, constant: -16),
            disconnectedInfoLabel.bottomAnchor.constraint(equalTo: talkButtonContainer.bottomAnchor, constant: -16)
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
        disconnectedInfoLabel.isHidden = false
        countUsersStackView.isHidden = true
        changeChannelButton.isHidden = true
        stopUserFetchTimer()
    }
}
