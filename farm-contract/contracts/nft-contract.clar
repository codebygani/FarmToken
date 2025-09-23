;; NFT Minting Contract
;; Implements SIP-009 NFT Standard for minting digital artworks

;; Define SIP-009 trait inline instead of importing external file
(define-trait nft-trait
  (
    (get-last-token-id () (response uint uint))
    (get-token-uri (uint) (response (optional (string-ascii 256)) uint))
    (get-owner (uint) (response (optional principal) uint))
    (transfer (uint principal principal) (response bool uint))
  )
)

;; Define the NFT according to SIP-009
(define-non-fungible-token digital-artwork uint)

;; Error constants
(define-constant ERR-NOT-AUTHORIZED (err u401))
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-ALREADY-EXISTS (err u409))
(define-constant ERR-INVALID-INPUT (err u400))

;; Contract owner
(define-constant CONTRACT-OWNER tx-sender)

;; Data variables
(define-data-var last-token-id uint u0)
(define-data-var mint-price uint u1000000) ;; 1 STX in microSTX

;; Data maps
(define-map token-metadata 
  uint 
  {
    title: (string-ascii 64),
    description: (string-ascii 256),
    image-url: (string-ascii 256),
    creator: principal,
    created-at: uint
  }
)

(define-map token-royalties uint uint) ;; token-id -> royalty percentage (basis points)

;; SIP-009 Functions

;; Get last token ID
(define-read-only (get-last-token-id)
  (ok (var-get last-token-id))
)

;; Get token URI - returns metadata
(define-read-only (get-token-uri (token-id uint))
  (match (map-get? token-metadata token-id)
    metadata (ok (some (get image-url metadata)))
    (ok none)
  )
)

;; Get owner of token
(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? digital-artwork token-id))
)

;; Transfer function
(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
    (asserts! (is-some (nft-get-owner? digital-artwork token-id)) ERR-NOT-FOUND)
    (nft-transfer? digital-artwork token-id sender recipient)
  )
)

;; Custom Functions

;; Mint new NFT
(define-public (mint-nft 
  (title (string-ascii 64))
  (description (string-ascii 256)) 
  (image-url (string-ascii 256))
  (recipient principal)
)
  (let 
    (
      (next-token-id (+ (var-get last-token-id) u1))
      (current-block-height block-height)
    )
    ;; Validate inputs
    (asserts! (> (len title) u0) ERR-INVALID-INPUT)
    (asserts! (> (len description) u0) ERR-INVALID-INPUT)
    (asserts! (> (len image-url) u0) ERR-INVALID-INPUT)
    
    ;; Mint the NFT
    (try! (nft-mint? digital-artwork next-token-id recipient))
    
    ;; Store metadata
    (map-set token-metadata next-token-id {
      title: title,
      description: description,
      image-url: image-url,
      creator: tx-sender,
      created-at: current-block-height
    })
    
    ;; Set default royalty (5% = 500 basis points)
    (map-set token-royalties next-token-id u500)
    
    ;; Update last token ID
    (var-set last-token-id next-token-id)
    
    ;; Return the new token ID
    (ok next-token-id)
  )
)

;; Mint NFT with payment
(define-public (mint-nft-paid
  (title (string-ascii 64))
  (description (string-ascii 256)) 
  (image-url (string-ascii 256))
)
  (let 
    (
      (mint-cost (var-get mint-price))
    )
    ;; Transfer payment to contract owner
    (try! (stx-transfer? mint-cost tx-sender CONTRACT-OWNER))
    
    ;; Mint the NFT to the sender
    (mint-nft title description image-url tx-sender)
  )
)

;; Update metadata (only by creator)
(define-public (set-metadata 
  (token-id uint)
  (title (string-ascii 64))
  (description (string-ascii 256))
  (image-url (string-ascii 256))
)
  (let 
    (
      (current-metadata (unwrap! (map-get? token-metadata token-id) ERR-NOT-FOUND))
    )
    ;; Only creator can update metadata
    (asserts! (is-eq tx-sender (get creator current-metadata)) ERR-NOT-AUTHORIZED)
    
    ;; Validate inputs
    (asserts! (> (len title) u0) ERR-INVALID-INPUT)
    (asserts! (> (len description) u0) ERR-INVALID-INPUT)
    (asserts! (> (len image-url) u0) ERR-INVALID-INPUT)
    
    ;; Update metadata
    (map-set token-metadata token-id (merge current-metadata {
      title: title,
      description: description,
      image-url: image-url
    }))
    
    (ok true)
  )
)

;; Set royalty percentage (only by creator)
(define-public (set-royalty (token-id uint) (royalty-bps uint))
  (let 
    (
      (current-metadata (unwrap! (map-get? token-metadata token-id) ERR-NOT-FOUND))
    )
    ;; Only creator can set royalties
    (asserts! (is-eq tx-sender (get creator current-metadata)) ERR-NOT-AUTHORIZED)
    ;; Royalty cannot exceed 50% (5000 basis points)
    (asserts! (<= royalty-bps u5000) ERR-INVALID-INPUT)
    
    (map-set token-royalties token-id royalty-bps)
    (ok true)
  )
)

;; Read-only functions

;; Get token metadata
(define-read-only (get-token-metadata (token-id uint))
  (map-get? token-metadata token-id)
)

;; Get token royalty
(define-read-only (get-token-royalty (token-id uint))
  (default-to u0 (map-get? token-royalties token-id))
)

;; Get mint price
(define-read-only (get-mint-price)
  (var-get mint-price)
)

;; Check if token exists
(define-read-only (token-exists (token-id uint))
  (is-some (nft-get-owner? digital-artwork token-id))
)

;; Get tokens owned by address
(define-read-only (get-tokens-owned (owner principal))
  ;; Simplified to return just the count using a working approach
  (let 
    (
      (last-id (var-get last-token-id))
    )
    ;; Use a simple iteration approach with predefined list
    (get count (fold check-token-ownership 
      (list u1 u2 u3 u4 u5 u6 u7 u8 u9 u10 u11 u12 u13 u14 u15 u16 u17 u18 u19 u20
            u21 u22 u23 u24 u25 u26 u27 u28 u29 u30 u31 u32 u33 u34 u35 u36 u37 u38 u39 u40
            u41 u42 u43 u44 u45 u46 u47 u48 u49 u50 u51 u52 u53 u54 u55 u56 u57 u58 u59 u60
            u61 u62 u63 u64 u65 u66 u67 u68 u69 u70 u71 u72 u73 u74 u75 u76 u77 u78 u79 u80
            u81 u82 u83 u84 u85 u86 u87 u88 u89 u90 u91 u92 u93 u94 u95 u96 u97 u98 u99 u100)
      { owner: owner, max-id: last-id, count: u0 }
    ))
  )
)

;; Helper function for fold operation
(define-private (check-token-ownership (token-id uint) (data { owner: principal, max-id: uint, count: uint }))
  (if (and (<= token-id (get max-id data)) 
           (is-eq (some (get owner data)) (nft-get-owner? digital-artwork token-id)))
    (merge data { count: (+ (get count data) u1) })
    data
  )
)

;; Get total supply
(define-read-only (get-total-supply)
  (var-get last-token-id)
)

;; Admin functions (only contract owner)

;; Update mint price
(define-public (set-mint-price (new-price uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set mint-price new-price)
    (ok true)
  )
)

;; Emergency transfer (only contract owner)
(define-public (admin-transfer (token-id uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (asserts! (is-some (nft-get-owner? digital-artwork token-id)) ERR-NOT-FOUND)
    (nft-transfer? digital-artwork token-id sender recipient)
  )
)

;; Burn NFT (only owner or creator)
(define-public (burn (token-id uint))
  (let 
    (
      (current-owner (unwrap! (nft-get-owner? digital-artwork token-id) ERR-NOT-FOUND))
      (metadata (unwrap! (map-get? token-metadata token-id) ERR-NOT-FOUND))
    )
    ;; Only current owner or creator can burn
    (asserts! (or (is-eq tx-sender current-owner) 
                  (is-eq tx-sender (get creator metadata))) ERR-NOT-AUTHORIZED)
    
    ;; Burn the NFT
    (try! (nft-burn? digital-artwork token-id current-owner))
    
    ;; Clean up metadata
    (map-delete token-metadata token-id)
    (map-delete token-royalties token-id)
    
    (ok true)
  )
)
