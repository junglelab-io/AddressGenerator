//
//  CoinsController.swift
//  AddressGenerator
//
//  Created by Khoa Pham on 21.12.2017.
//  Copyright © 2017 Khoa Pham. All rights reserved.
//

import AppKit
import Anchors

final class CoinsController: BaseController, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {
  var titleLabel: Label!
  var collectionView: NSCollectionView!
  let coins = CoinList.allCoins
  var select: ((CoinAware) -> Void)?

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    titleLabel = Label()
    titleLabel.textColor = .white
    titleLabel.stringValue = "Choose currency"
    view.addSubview(titleLabel)
    activate(
      titleLabel.anchor.top.left
    )

    let layout = NSCollectionViewFlowLayout()
    layout.minimumLineSpacing = 4

    collectionView = NSCollectionView()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.collectionViewLayout = layout
    collectionView.allowsMultipleSelection = false
    collectionView.backgroundColors = [.clear]

    view.addSubview(collectionView)
    activate(
      collectionView.anchor.top.equal.to(titleLabel.anchor.bottom).constant(10),
      collectionView.anchor.left.bottom.right
    )
  }

  // MARK: - NSCollectionViewDataSource

  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return coins.count
  }

  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let cell = Cell()
    let coin = coins[indexPath.item]

    cell.label.stringValue = coin.name
    cell.coinImageView.image =
      NSImage(named: NSImage.Name(rawValue: coin.name))
      ?? NSImage(named: NSImage.Name(rawValue: "Others"))

    return cell
  }

  // MARK: - NSCollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    guard let indexPath = indexPaths.first else {
      assertionFailure()
      return
    }

    let coin = coins[indexPath.item]
    select?(coin)
  }

  func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {

    return NSSize(
      width: collectionView.frame.size.width,
      height: 40
    )
  }
}