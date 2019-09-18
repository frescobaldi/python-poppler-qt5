namespace Poppler {

class FormField {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-form.h>
%End

public:
    enum FormType {
        FormButton,
        FormText,
        FormChoice,
        FormSignature,
    };
    virtual ~FormField();
    virtual FormType type() const = 0;
    QRectF rect() const;
    int id() const;
    QString name() const;
%If(POPPLER_V0_51_0 -)
    void setName(const QString &name) const;
%End
%If(POPPLER_V0_20_0 -)
    QString fullyQualifiedName() const;
%End
    QString uiName() const;
    bool isReadOnly() const;
    bool isVisible() const;
    Poppler::Link* activationAction() const;
%If(POPPLER_V0_53_0 -)
	enum AdditionalActionType
	{
	    FieldModified,   ///< A JavaScript action to be performed when the user modifies the field
	    FormatField,     ///< A JavaScript action to be performed before the field is formatted to display its value
	    ValidateField,   ///< A JavaScript action to be performed when the field value changes
	    CalculateField,  ///< A JavaScript action to be performed when the field needs to be recalculated
	};
	Link* additionalAction(AdditionalActionType type) const;
%End

private:
    FormField(const Poppler::FormField&);
    
%ConvertToSubClassCode
    switch (sipCpp->type()) {
        case Poppler::FormField::FormButton:
            sipType = sipType_Poppler_FormFieldButton;
            break;
        case Poppler::FormField::FormText:
            sipType = sipType_Poppler_FormFieldText;
            break;
        case Poppler::FormField::FormChoice:
            sipType = sipType_Poppler_FormFieldChoice;
            break;
        default:
            sipType = sipType_Poppler_FormField;
    }
%End

}; // class FormField


class FormFieldButton : Poppler::FormField {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-form.h>
%End

public:
    enum ButtonType {
        Push,
        CheckBox,
        Radio,
    };
//     FormFieldButton(DocumentData *doc, ::Page *p, ::FormWidgetButton *w);
    virtual ~FormFieldButton();
    virtual FormType type() const;
    ButtonType buttonType() const;
    QString caption() const;
    bool state() const;
    void setState( bool state );
    QList<int> siblings() const;

private:
    FormFieldButton(const Poppler::FormFieldButton&);
    
}; // class FormFieldButton


class FormFieldText : Poppler::FormField {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-form.h>
%End

public:
    enum TextType {
        Normal,
        Multiline,
        FileSelect,
    };
//     FormFieldText(DocumentData *doc, ::Page *p, ::FormWidgetText *w);
    virtual ~FormFieldText();
    virtual FormType type() const;
    TextType textType() const;
    QString text() const;
    void setText( const QString& text );
    bool isPassword() const;
    bool isRichText() const;
    int maximumLength() const;
    Qt::Alignment textAlignment() const;
    bool canBeSpellChecked() const;
    double getFontSize() const;
    void setFontSize(int fontSize);

private:
    FormFieldText(const Poppler::FormFieldText&);
    
}; // class FormFieldText


class FormFieldChoice : Poppler::FormField {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-form.h>
%End

public:
    enum ChoiceType {
        ComboBox,
        ListBox,
    };
//     FormFieldChoice(DocumentData *doc, ::Page *p, ::FormWidgetChoice *w);
    virtual ~FormFieldChoice();
    virtual FormType type() const;
    ChoiceType choiceType() const;
    QStringList choices() const;
    bool isEditable() const;
    bool multiSelect() const;
    QList<int> currentChoices() const;
    void setCurrentChoices( const QList<int> &choice );
%If(POPPLER_V0_22_0 -)
    QString editChoice() const;
    void setEditChoice(const QString& text);
%End
    Qt::Alignment textAlignment() const;
    bool canBeSpellChecked() const;

private:
    FormFieldChoice(const Poppler::FormFieldChoice&);
    
}; // class FormFieldChoice

%If(POPPLER_V0_51_0 -)
class SignatureValidationInfo {
%TypeHeaderCode
#include <time.h>
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-form.h>
%End
    public:
	enum SignatureStatus {
	    SignatureValid,          ///< The signature is cryptographically valid.
	    SignatureInvalid,        ///< The signature is cryptographically invalid.
	    SignatureDigestMismatch, ///< The document content was changed after the signature was applied.
	    SignatureDecodingError,  ///< The signature CMS/PKCS7 structure is malformed.
	    SignatureGenericError,   ///< The signature could not be verified.
	    SignatureNotFound,       ///< The requested signature is not present in the document.
	    SignatureNotVerified     ///< The signature is not yet verified.
	};
	enum CertificateStatus {
	    CertificateTrusted,         ///< The certificate is considered trusted.
	    CertificateUntrustedIssuer, ///< The issuer of this certificate has been marked as untrusted by the user.
	    CertificateUnknownIssuer,   ///< The certificate trust chain has not finished in a trusted root certificate.
	    CertificateRevoked,         ///< The certificate was revoked by the issuing certificate authority.
	    CertificateExpired,         ///< The signing time is outside the validity bounds of this certificate.
	    CertificateGenericError,    ///< The certificate could not be verified.
	    CertificateNotVerified      ///< The certificate is not yet verified.
	};

%If(POPPLER_V0_60_0 -)
	enum HashAlgorithm
	{
	    HashAlgorithmUnknown,
	    HashAlgorithmMd2,
	    HashAlgorithmMd5,
	    HashAlgorithmSha1,
	    HashAlgorithmSha256,
	    HashAlgorithmSha384,
	    HashAlgorithmSha512,
	    HashAlgorithmSha224
	};
%End
	SignatureStatus signatureStatus() const;
	CertificateStatus certificateStatus() const;
	QString signerName() const;
%If(POPPLER_V0_60_0 -)
	QString signerSubjectDN() const;
	HashAlgorithm hashAlgorithm() const;
    time_t signingTime() const;
    QByteArray signature() const;
    QList<qint64> signedRangeBounds() const;
    bool signsTotalDocument() const;

	private:
    SignatureValidationInfo(const SignatureValidationInfo &other);
    //SignatureValidationInfo &operator=(const SignatureValidationInfo &other);
%End

}; // class SignatureValidationInfo

class FormFieldSignature : Poppler::FormField {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-form.h>
%End
    public:

%If(POPPLER_V0_60_0 -)
	enum SignatureType {
	    AdbePkcs7sha1,
	    AdbePkcs7detached,
	    EtsiCAdESdetached
	};
%End
	enum ValidateOptions {
	    ValidateVerifyCertificate = 1, ///< Validate the certificate.
	    ValidateForceRevalidation = 2, ///< Force revalidation of the certificate.
	};

    private:
	//FormFieldSignature(DocumentData *doc, ::Page *p, ::FormWidgetSignature *w);
	//~FormFieldSignature();
    FormFieldSignature(const Poppler::FormFieldSignature&);
    
	FormType type() const;
%If(POPPLER_V0_60_0 -)
	SignatureType signatureType() const;
%End

	SignatureValidationInfo validate(ValidateOptions opt) const;
%If(POPPLER_V0_60_0 -)
	SignatureValidationInfo validate(int opt, const QDateTime& validationTime) const;
%End
};  // FormFieldSignature

%End // POPPLER_V0_51_0




}; // namespace Poppler

/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
