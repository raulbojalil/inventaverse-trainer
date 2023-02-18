using System.Net.Http.Headers;
using System.Net;

namespace MauiApp1;

public partial class MainPage : ContentPage
{
    int count = 0;

    public MainPage()
    {
        InitializeComponent();
    }

    private async void OnSaveClicked(object sender, EventArgs e)
    {

        var handler = new HttpClientHandler();

        handler.AutomaticDecompression = ~DecompressionMethods.None;

        using (var httpClient = new HttpClient(handler))
        {
            using (var request = new HttpRequestMessage(new HttpMethod("PUT"), "https://inventaverse.com/api/User/" + txtUserId.Text))
            {
                request.Headers.TryAddWithoutValidation("authority", "inventaverse.com");
                request.Headers.TryAddWithoutValidation("accept", "*/*");
                request.Headers.TryAddWithoutValidation("accept-language", "fr,en;q=0.9,de;q=0.8");
                request.Headers.TryAddWithoutValidation("cookie", txtCookie.Text);
                request.Headers.TryAddWithoutValidation("origin", "https://inventaverse.com");
                request.Headers.TryAddWithoutValidation("referer", "https://inventaverse.com/js/game/home.html");
                request.Headers.TryAddWithoutValidation("sec-ch-ua", "^^");
                request.Headers.TryAddWithoutValidation("sec-ch-ua-mobile", "?0");
                request.Headers.TryAddWithoutValidation("sec-ch-ua-platform", "^^");
                request.Headers.TryAddWithoutValidation("sec-fetch-dest", "empty");
                request.Headers.TryAddWithoutValidation("sec-fetch-mode", "cors");
                request.Headers.TryAddWithoutValidation("sec-fetch-site", "same-origin");
                request.Headers.TryAddWithoutValidation("user-agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36");
                request.Headers.TryAddWithoutValidation("x-requested-with", "XMLHttpRequest");


                var body = @" 
                    {""artifacts"":[26,11,3],
                    ""owned"":[12,27,28,20,24,3,16,25,4,2,17,10,22,1,5,6,7,8,9,11,13,14,15,16,18,19,21,23,26,29,30],
                    ""fighters"":[0,1,2,3,4,5,6,7,8,9,12,13,14,16,8,7,10,11,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30],
                    ""mentor"":1,
                    ""progress"":15,
                    ""treasure"": {""gold"":56409,""inceptium"":30,""commendations"":0},
                    ""skills"":[50,45,46,44,49,47,48,5,39,41,35,32,30,33,34],
                    ""stats"":{""k"":500,""e"":200,""d"":252,""t"":1,""r"":2,""w"":7,""c"":24},""fleet"":[0],
                    ""puzzles[A"":[1659537892263],
                    ""magics"":[2,1,0],
                    ""mazes"":[1673362333676,1673314351257],
                    ""history"":[{""W"":1674166802618,""I"":""-NJhXA6pKlHd7Qy7p4yQ""}],
                    ""incantations"":[""if(API.Self.Health < .2) {\n   API.Self.Use(3)\n}"","""",""""]} ";

                request.Content = new StringContent(body);
                request.Content.Headers.ContentType = MediaTypeHeaderValue.Parse("application/json");

                var response = await httpClient.SendAsync(request);
            }
        }
    }
}



