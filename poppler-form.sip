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
    QString uiName() const;
    bool isReadOnly() const;
    bool isVisible() const;
    Poppler::Link* activationAction() const;

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
    Qt::Alignment textAlignment() const;
    bool canBeSpellChecked() const;

private:
    FormFieldChoice(const Poppler::FormFieldChoice&);
    
};


}; // namespace Poppler

/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
