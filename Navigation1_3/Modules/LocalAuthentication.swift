
import Foundation
import LocalAuthentication


final class LocalAuthentication {
    
    enum BiometricType {
        case none
        case touchID
        case FaceID
        case unknown
    }
    
    enum BiometricError: LocalizedError {
        case authentificationFailed
        case userCancel
        case userFallback
        case biomtryNotAvailable
        case biometricNotEnrobled
        case biometrictryLockout
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .authentificationFailed:
                return "authentificationFailed".localized
            case .userCancel:
                return "userCancel".localized
            case .userFallback:
                return "userFallback".localized
            case .biomtryNotAvailable:
                return "biomtryNotAvailable".localized
            case .biometricNotEnrobled:
                return "biometricNotEnrobled".localized
            case .biometrictryLockout:
                return "biometrictryLockout".localized
            case .unknown:
                return "unknown".localized
            }
        }
    }
    
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String
    
    private var error: NSError?
    
    init(policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
         localizedReason: String = "localizedReason".localized,
         localizedFallbackTitle: String = "localizedFallbackTitle".localized
    ) {
        self.policy = policy
        self.localizedReason = localizedReason
        context.localizedFallbackTitle = localizedFallbackTitle
        context.localizedCancelTitle = "Touch me not"
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        context.evaluatePolicy(policy, localizedReason: localizedReason) { success, _ in
            DispatchQueue.main.async {
                guard success else {
                    return authorizationFinished(false)
                }
                authorizationFinished(true)
            }
        }
    }
    
    func authorizationFinished(complitionHandler: (Bool, BiometricType, BiometricError?) -> Void) {
        guard context.canEvaluatePolicy(policy, error: &error) else {
            let type = biometricType(for: context.biometryType)
            
            guard let error else {
                return complitionHandler(false, type, nil)
            }
            return complitionHandler(false, type, biometricError(from: error))
        }
        
        complitionHandler(true, biometricType(for: context.biometryType), nil)
    }
    
    private func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .FaceID
        @unknown default:
            return .unknown
        }
    }
    
    private func biometricError(from nsError: NSError) -> BiometricError {
        let error: BiometricError
        
        switch nsError {
        case LAError.authenticationFailed:
            error = .authentificationFailed
        case LAError.userFallback:
            error = .userFallback
        case LAError.appCancel:
            error = .userCancel
        case LAError.biometryLockout:
            error = .biometrictryLockout
        case LAError.biometryNotEnrolled:
            error = .biometricNotEnrobled
        case LAError.biometryNotAvailable:
            error = .biomtryNotAvailable
        default:
            error = .unknown
        }
        return error
    }
}

