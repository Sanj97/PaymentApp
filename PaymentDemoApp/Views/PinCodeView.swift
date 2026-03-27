//
//  PinCodeView.swift
//  PaymentDemoApp
//
//  Created by Sanjar Yalgashev on 08/05/25.
//

import SwiftUI

struct PinCodeView: View {
    private let quickActions: [QuickAction] = [
        .init(title: "Withdraw", icon: "arrow.up.right"),
        .init(title: "Deposit", icon: "arrow.down.left")
    ]

    private let cards: [PaymentCard] = [
        .init(type: "VISA", holder: "James Anderson", expiresAt: "Exp 09/24", backgroundColor: .black, foregroundColor: .white),
        .init(type: "Mastercard", holder: "Maddy Anderson", expiresAt: "Exp 03/25", backgroundColor: Color(.systemGray5), foregroundColor: .primary)
    ]

    private let transactions: [TransactionItem] = [
        .init(icon: "N", service: "Netflix", amount: "-$12.58", color: Color(red: 0.97, green: 0.91, blue: 0.79)),
        .init(icon: "S", service: "Spotify", amount: "-$16.35", color: Color(red: 0.90, green: 0.95, blue: 0.64)),
        .init(icon: "T", service: "Twitch", amount: "-$8.20", color: Color(red: 0.89, green: 0.95, blue: 0.90))
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                header
                balanceBlock
                quickActionsBlock
                cardsBlock
                transactionsBlock
            }
            .padding(18)
        }
        .background(Color(red: 0.87, green: 0.96, blue: 0.86).ignoresSafeArea())
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Hello James!")
                    .font(.system(size: 34, weight: .bold))
                Text("Your balance")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            NavigationLink(destination: PlaceholderView(title: "Profile")) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.black)
            }
        }
    }

    private var balanceBlock: some View {
        Text("$24,713.11")
            .font(.system(size: 52, weight: .semibold, design: .rounded))
            .minimumScaleFactor(0.75)
            .lineLimit(1)
    }

    private var quickActionsBlock: some View {
        HStack(spacing: 12) {
            ForEach(quickActions) { action in
                NavigationLink(destination: PlaceholderView(title: action.title)) {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(.black)
                            .frame(width: 28, height: 28)
                            .overlay {
                                Image(systemName: action.icon)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(.white)
                            }

                        Text(action.title)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.77, green: 0.93, blue: 0.77))
                    .clipShape(Capsule())
                }
            }
        }
    }

    private var cardsBlock: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(cards) { card in
                    NavigationLink(destination: PlaceholderView(title: card.type + " card")) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(card.type)
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(card.foregroundColor.opacity(0.2))
                                .clipShape(Capsule())

                            Spacer()

                            Text(card.holder)
                                .font(.title2.weight(.medium))
                                .multilineTextAlignment(.leading)
                            Text(card.expiresAt)
                                .font(.subheadline)
                                .foregroundStyle(card.foregroundColor.opacity(0.75))
                        }
                        .padding(16)
                        .frame(width: 170, height: 190)
                        .background(card.backgroundColor)
                        .foregroundStyle(card.foregroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                    }
                }
            }
        }
    }

    private var transactionsBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Transactions")
                .font(.title2.weight(.semibold))

            ForEach(transactions) { item in
                NavigationLink(destination: PlaceholderView(title: item.service)) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(.black.opacity(0.08))
                                .frame(width: 34, height: 34)
                            Text(item.icon)
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }

                        Text(item.service)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Spacer()

                        Text(item.amount)
                            .font(.system(size: 38, weight: .medium, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                            .foregroundStyle(.primary)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(item.color)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                }
            }
        }
    }
}

private struct QuickAction: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

private struct PaymentCard: Identifiable {
    let id = UUID()
    let type: String
    let holder: String
    let expiresAt: String
    let backgroundColor: Color
    let foregroundColor: Color
}

private struct TransactionItem: Identifiable {
    let id = UUID()
    let icon: String
    let service: String
    let amount: String
    let color: Color
}

private struct PlaceholderView: View {
    let title: String

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.89, green: 0.97, blue: 0.90), .white],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "sparkles")
                    .font(.system(size: 50))
                Text(title)
                    .font(.largeTitle.bold())
                Text("This is a simple destination screen.")
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PinCodeView()
    }
}
