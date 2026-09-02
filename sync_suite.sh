#!/usr/bin/env bash
# sync_suite.sh — Automated Git Synchronization for Higgs-Gluon Master Suite & Submodules
set -euo pipefail

SUITE_ROOT="/home/rick/open-source/Higgs-Gluon"
SUBMODULES=("higgs-gluon-kernel" "higgs-gluon-musl-clang" "higgs-gluon-ndk")

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${CYAN}[*] Starting Higgs-Gluon Suite Synchronization...${NC}"

# 1. Sync & Push each submodule
for sub in "${SUBMODULES[@]}"; do
    SUB_DIR="${SUITE_ROOT}/${sub}"
    if [ ! -e "${SUB_DIR}/.git" ]; then
        echo -e "${YELLOW}[!] Submodule ${sub} not found or missing .git at ${SUB_DIR}${NC}"
        continue
    fi
    echo -e "${CYAN}── Checking Submodule: ${sub} ──${NC}"
    
    # Check for uncommitted changes
    if [ -n "$(git -C "${SUB_DIR}" status --porcelain)" ]; then
        echo -e "  ${YELLOW}[*] Staging and committing changes in ${sub}...${NC}"
        git -C "${SUB_DIR}" add -A
        git -C "${SUB_DIR}" commit -m "chore(${sub}): automated release sync $(date +%Y-%m-%d)" || true
    fi
    
    # Check if ahead of remote
    BRANCH=$(git -C "${SUB_DIR}" rev-parse --abbrev-ref HEAD)
    REMOTE_URL=$(git -C "${SUB_DIR}" remote get-url origin 2>/dev/null || echo "")
    if [ -n "${REMOTE_URL}" ]; then
        echo -e "  ${CYAN}[*] Pushing ${sub} (${BRANCH}) -> ${REMOTE_URL}...${NC}"
        git -C "${SUB_DIR}" push -u origin "${BRANCH}"
        echo -e "  ${GREEN}✓ ${sub} pushed successfully.${NC}"
    else
        echo -e "  ${YELLOW}[!] No remote 'origin' configured for ${sub}.${NC}"
    fi
done

# 2. Sync & Push Master Suite
echo -e "${CYAN}── Checking Master Suite: Higgs-Gluon ──${NC}"
if [ -n "$(git -C "${SUITE_ROOT}" status --porcelain)" ]; then
    echo -e "  ${YELLOW}[*] Staging submodule pointers and suite documentation...${NC}"
    git -C "${SUITE_ROOT}" add -A
    git -C "${SUITE_ROOT}" commit -m "chore(suite): update submodule pointers and release manifests $(date +%Y-%m-%d)" || true
fi

MASTER_BRANCH=$(git -C "${SUITE_ROOT}" rev-parse --abbrev-ref HEAD)
echo -e "  ${CYAN}[*] Pushing Higgs-Gluon master (${MASTER_BRANCH})...${NC}"
git -C "${SUITE_ROOT}" push origin "${MASTER_BRANCH}"
echo -e "${GREEN}[+] Higgs-Gluon Suite fully synchronized and up to date!${NC}"
