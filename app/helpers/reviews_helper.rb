module ReviewsHelper
    def review_rating_fields
        [
            {
                field: :value_rating,
                label: "Oceń wartość",
                description: "Czy jedzenie jest dobrze przygotowane, świeże i smaczne? Jak wyglądają dania? Czy oferta jest zróżnicowana, dostosowana do różnych preferencji dietetycznych?"
            },
            {
                field: :service_rating,
                label: "Oceń serwis",
                description: "Czy obsługa jest uprzejma, pomocna i kompetentna? Czy czas oczekiwania jest adekwatny do rodzaju potraw?"
            },
            {
                field: :atmosphere_rating,
                label: "Oceń atmosferę",
                description: "Czy restauracja jest estetyczna, wygodna i przytulna? Czy muzyka i światło są odpowiednie, tworząc przyjemny nastrój?"
            },
            {
                field: :quality_rating,
                label: "Oceń jakość",
                description: "Czy ceny są odpowiednie do jakości jedzenia i obsługi? Czy lokal i jego otoczenie są zadbane, czyste i schludne?"
            },
            {
                field: :availability_rating,
                label: "Oceń dostępność",
                description: "Czy restauracja znajduje się w dogodnym miejscu? Czy restauracja jest otwarta w dogodnych dla klientów godzinach?"
            },
            {
                field: :uniqueness_rating,
                label: "Oceń unikalność",
                description: "Czy restauracja oferuje oryginalne dania lub unikalne połączenia smakowe? Czy oferowanie tradycyjne dania są wyjątkowe w swoim smaku?"
            }
          ]
    end
end
