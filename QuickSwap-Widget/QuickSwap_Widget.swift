//
//  QuickSwap_Widget.swift
//  QuickSwap-Widget
//
//  Created by Piotr Szadkowski on 12/07/2020.
//

import WidgetKit
import SwiftUI
import Intents
import Combine

struct CurrencyEntry: TimelineEntry {
    let date: Date
    let currency: CurrencyConversion
}

struct Provider: TimelineProvider {
    
    let provider: CurrencyProvider
    
    init(provider: CurrencyProvider = CurrencyService()) {
        self.provider = provider
    }
    
    func snapshot(with context: Context, completion: @escaping (CurrencyEntry) -> ()) {
        let entry = CurrencyEntry(date: Date(), currency: .plnMock)
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<CurrencyEntry>) -> ()) {
        _ = provider.fetchCurrencies(for: "PLN")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { conversion in
                let entries = CurrencyEntry(date: conversion.date, currency: conversion)
                
                let timeline = Timeline(entries: [entries], policy: .atEnd)
                completion(timeline)
            })
    }
    
}

struct CurrencyPlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct CurrencyEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            CurrencyRowView(viewModel: .init(entry.currency.exchangeRates[0]))
            Spacer()
            CurrencyRowView(viewModel: .init(entry.currency.exchangeRates[1]))
        }
    }
}

@main
struct QuickSwap_Widget: Widget {
    private let kind: String = "QuickSwap_Widget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider(provider: CurrencyServiceFake()),
                            placeholder: CurrencyPlaceholderView(),
                            content: { entry in
                                CurrencyEntryView(entry: entry)
                                    .environmentObject(UserDetails(initialMoney: "1"))
                            })
        .configurationDisplayName("Currency Widget")
        .description("Show your favourite currency")
    }
}

struct QuickSwap_Widget_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyEntryView(entry: .init(date: Date(), currency: .plnMock))
    }
}
