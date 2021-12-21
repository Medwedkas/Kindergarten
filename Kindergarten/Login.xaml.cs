using Kindergarten.source.api;
using System;
using System.Threading.Tasks;
using System.Windows;
using ToastNotifications;
using ToastNotifications.Lifetime;
using ToastNotifications.Position;
using ToastNotifications.Messages;
using Kindergarten.source;
using Kindergarten.source.utils;
using Kindergarten.source.global;

namespace Kindergarten
{
    /// <summary>
    /// Interaction logic for Login.xaml
    /// </summary>
    public partial class Login : Window
    {
        private readonly Notifier notifier = new Notifier(cfg =>
        {
            cfg.PositionProvider = new WindowPositionProvider(
                parentWindow: Application.Current.MainWindow,
                corner: Corner.TopRight,
                offsetX: 10,
                offsetY: 10);

            cfg.LifetimeSupervisor = new TimeAndCountBasedLifetimeSupervisor(
                notificationLifetime: TimeSpan.FromSeconds(3),
                maximumNotificationCount: MaximumNotificationCount.FromCount(5));

            cfg.Dispatcher = Application.Current.Dispatcher;
        });

        private readonly Api api = new Api();

        public Login()
        {
            if (!String.IsNullOrEmpty(Storage.LoadValue("token")?.ToString()))
            {
                if (api.CheckToken())
                {
                    var window = WindowMapper.Map(InfoKeeper.User.Role);
                    window.Show();
                    this.Close();
                }
            }
            InitializeComponent();
            
        }

        public async Task<bool> DoAuth()
        {
            return await api.Authorization(LoginField.Text, PasswordField.Password);
        }

        private void LoginField_GotFocus(object sender, RoutedEventArgs e)
        {
            if (LoginField.Text == "Логин")
                LoginField.Text = String.Empty;
        }

        private void LoginField_LostFocus(object sender, RoutedEventArgs e)
        {
            if (LoginField.Text == String.Empty)
                LoginField.Text = "Логин";
        }

        private void PasswordField_GotFocus(object sender, RoutedEventArgs e)
        {
            if (PasswordField.Password == "Пароль")
                PasswordField.Password = String.Empty;
        }

        private void PasswordField_LostFocus(object sender, RoutedEventArgs e)
        {
            if (PasswordField.Password == String.Empty)
                PasswordField.Password = "Пароль";
        }

        private async void SubmitButton_Click(object sender, RoutedEventArgs e)
        {
            if (LoginField.Text == "Логин" || LoginField.Text.Length < 3)
            {
                notifier.ShowError("Поле логина не может быть пустым");
                return;
            }

            if (PasswordField.Password.Length < 3)
            {
                notifier.ShowError("Поле пароля не может быть пустым");
                return;
            }

            if (await DoAuth())
            {
                var window = WindowMapper.Map(InfoKeeper.User.Role);
                window.Show();
                this.Close();
            }
            else
            {
                notifier.ShowError("Неверный логин или пароль");
                return;
            }
        }
    }
}
