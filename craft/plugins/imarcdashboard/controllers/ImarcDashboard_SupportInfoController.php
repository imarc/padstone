<?php
namespace Craft;

class ImarcDashboard_SupportInfoController extends BaseController
{
    public function actionContactSupport()
    {

        $fromEmail  = trim(craft()->requst->getPost('fromEmail'));
        $message    = trim(craft()->request->getPost('message'));

        if ($fromEmail && $message) {
            $site_url = craft()->getSiteUrl();
            $site_name = craft()->getSiteName();

            $email = new EmailModel();
            $email->toEmail = 'kevin@imarc.com';
            $email->subject = "Support Request from $site_name";
            $email->body = "Message from $site_name ($site_url):\n\n$message";

            if (craft()->request->getPost('attachFile')) {
                $email->addAttachment(UploadedFile::getInstanceByName('attachFile'));
            }

            craft()->email->sendEmail($email);

            $_POST['sent_successfully'] = true;
        }
    }

}
