/**
*  Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

#if canImport(ShellOut)
import ShellOut

extension ShellOutError: PublishingErrorConvertible {
    func publishingError(forStepNamed stepName: String?) -> PublishingError {
        PublishingError(
            stepName: stepName,
            path: nil,
            infoMessage: message,
            underlyingError: nil
        )
    }
}
#endif
